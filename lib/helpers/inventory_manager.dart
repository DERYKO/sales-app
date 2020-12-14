import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/inventory.dart';
import 'package:solutech_sat/data/models/order_item.dart';
import 'package:solutech_sat/data/models/product.dart';
import 'package:solutech_sat/data/models/received_good.dart';
import 'package:solutech_sat/data/models/stock.dart';
import 'package:solutech_sat/data/models/stock_item.dart';
import 'package:solutech_sat/data/models/stockpoint_stock_level.dart';
import 'package:solutech_sat/data/models/virtual_stock.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/manager.dart';
import 'package:solutech_sat/utils/format_utils.dart';
import 'package:solutech_sat/utils/image_utils.dart';

class InventoryManager extends Manager {
  static InventoryManager instance;
  factory InventoryManager() => instance ??= InventoryManager._instance();
  InventoryManager._instance();
  List<VirtualStock> virtualStock = [];
  List<StockpointStockLevel> stockPointStock = [];
  List<Stock> stocks = [];
  List<StockItem> stockItems = [];
  String errorText = "";
  bool _loadingStock = false;

  bool get loadingStock => _loadingStock;

  set loadingStock(bool show) {
    _loadingStock = show;
    notifyChanges();
  }

  Map<String, List<VirtualStock>> get groupedVirtualStock =>
      groupBy(virtualStock, (VirtualStock stock) => stock.category);

  Future<Map<String, dynamic>> _buildStockSyncPayload(Stock stock) async {
    return {
      "entry_type": stock.entryType,
      "supplier_id": "${stock.supplierId}",
      "saler_id": "${stock.salerId}",
      "comment": stock.comment,
      "payment_method": stock.paymentMethod,
      "reference": stock.reference,
      "entry_time": formatDate(stock.entryTime, "xt"),
      "latitude": stock.latitude,
      "longitude": stock.longitude,
      "stockitems": json.encode(_buildStockItems(stock)),
      "photo": (stock.photo != null && stock.photo.trim() != "")
          ? await base64FromFile(File(stock.photo))
          : null,
    };
  }

  List<Map<String, dynamic>> _buildStockItems(Stock stock) {
    return stockItems
        .where((stockItem) => stockItem.stockId == stock.id)
        .toList()
        .map((stockItem) {
      return {
        "product_id": stockItem.productId,
        "quantity": (stockItem.unit == "ctns")
            ? stockItem.quantity * stockItem.crtQnty
            : stockItem.quantity,
        "buying_price": stockItem.price,
        "batchnumber": stockItem.batchnumber,
        "totalcost": (stockItem.unit == "ctns")
            ? stockItem.price * (stockItem.quantity * stockItem.crtQnty)
            : stockItem.price * stockItem.quantity,
        "store_id": stock.supplierId,
      };
    }).toList();
  }

  List<String> stockPointStockCategories(int stockPointId) {
    return [
      ...Set.from(
        stockPointStock
            .where((stock) =>
                stock.storeId == stockPointId &&
                double.parse("${stock.quantity}") > 0)
            .toList()
            .map((product) => product.category),
      ),
    ];
  }

  List<String> get virtualStockCategories {
    return [
      ...Set.from(
        virtualStock.map((product) => product.category),
      ),
    ];
  }

  List<StockItem> stockItemsFor(int stockId) {
    return stockItems.where((item) => item.stockId == stockId).toList();
  }

  double stockItemsTotalFor(int stockId) {
    return stockItems
        .where((item) => item.stockId == stockId)
        .fold(0.0, (a, b) => a + (b.price * b.quantity));
  }

  Future getDBData() async {
    virtualStock = await db.virtualStockBean.getAll();
    stocks = await db.stockBean.getAll();
    stockItems = await db.stockItemBean.getAll();
    stockPointStock = await db.stockpointStockLevelBean.getAll();
    notifyChanges();
  }

  int stockPointStockLevel(int productId) {
    var stock = stockPointStock.firstWhere(
        (stock) => stock.productId == productId,
        orElse: () => null);
    if (stock == null) return 0;
    print(
        "Product: ${stock?.productDesc}, quantity: $stockPointStockLevel.quantity");
    return int.parse("${stock.quantity ?? 0}");
  }

  int virtualStockLevel(int productId, batchnumber) {
    var stock = virtualStock.firstWhere(
        (stock) =>
            stock.productId == productId && stock.batchnumber == batchnumber,
        orElse: () => null);
    if (stock == null) return 0;
    print(
        "Product: ${stock?.productDesc}, quantity: $stockPointStockLevel.quantity");
    return int.parse("${stock.quantity ?? 0}");
  }

  Future loadVirtualStock() {
    return api.getVirtualStock().then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        _saveVirtualStockLocally(payload);
        return response;
      } else {
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future loadStock([List<DateTime> pickedDates]) {
    loadingStock = true;
    var filterDates = filterDatesFrom(pickedDates);
    return api.getStock(filterDates).then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        _saveStockLocally(payload);
        loadingStock = false;
        return response;
      } else {
        loadingStock = false;
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future loadStockPointStock() {
    return api.getStockPointStock().then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        _saveStockPointStockLocally(payload);
        return response;
      } else {
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future saveStock({Stock stock, List<StockItem> stockItems}) async {
    int result = await db.stockBean.insert(stock..fromServer = false);
    stockItems.forEach((item) async {
      await db.stockItemBean.insert(item..stockId = result);
      if (stock.entryType != "Requisition" && stock.entryType != "Returns") {
        if (!roleManager.hasRole(Roles.ENFORCE_VALIDATION)) {
          await addVirtualStock(item);
        }
        if (roleManager.hasRole(Roles.VIRTUAL_WITH_STOCKPOINT) &&
            !roleManager.hasRole(Roles.ENFORCE_VALIDATION)) {
          await subtractStockPointStock(item, stock.supplierId);
        }
      } else if (stock.entryType == "Returns") {
        await subtractVirtualStockForStock(item);
        if (roleManager.hasRole(Roles.VIRTUAL_WITH_STOCKPOINT)) {
          await addStockPointStock(item, stock.supplierId);
        }
      }
    });
    print("Stock inserted");
    await getDBData();
    syncManager.sync();
  }

  Future subtractVirtualStockForOrder(OrderItem orderItem) async {
    var virtualStock = await db.virtualStockBean.findOneWhere(db
        .virtualStockBean.productId
        .eq(orderItem.productId)
        .and(db?.virtualStockBean?.batchnumber?.eq(orderItem.batchnumber)));
    if (virtualStock != null) {
      virtualStock.quantity =
          "${int.parse(virtualStock.quantity) - ((orderItem.productPackaging == "ctns") ? (orderItem.quantity * orderItem.cartonQuantity) : orderItem.quantity)}";
      await db.virtualStockBean.update(virtualStock);
    }
    await getDBData();
  }

  Future subtractVirtualStockForStock(StockItem orderItem) async {
    var virtualStock = await db.virtualStockBean.findOneWhere(db
        .virtualStockBean.productId
        .eq(orderItem.productId)
        .and(db?.virtualStockBean?.batchnumber?.eq(orderItem.batchnumber)));
    if (virtualStock != null) {
      virtualStock.quantity =
          "${int.parse(virtualStock.quantity) - ((orderItem.unit == "ctns") ? (orderItem.quantity * orderItem.crtQnty) : orderItem.quantity)}";
      await db.virtualStockBean.update(virtualStock);
    }
    await getDBData();
  }

  Future addVirtualStock(StockItem stockItem) async {
    var virtualStock = this.virtualStock.firstWhere(
        (virtualStock) => virtualStock.productId == stockItem.productId,
        orElse: () => null);
    if (virtualStock == null) {
      var virtualStock = VirtualStock(
        productDesc:
            commonsManager.productById(stockItem.productId)?.productDesc,
        quantity:
            "${(stockItem.unit == "ctns") ? (stockItem.quantity * stockItem.crtQnty) : stockItem.quantity}",
        category:
            commonsManager.productById(stockItem.productId).productCategory,
        productId: stockItem.productId,
        storeId: stockItem.stockId,
      );
      await db.virtualStockBean.insert(virtualStock);
      print("Added virtual stock");
    } else {
      virtualStock.quantity =
          "${int.parse(virtualStock.quantity) + ((stockItem.unit == "ctns") ? (stockItem.quantity * stockItem.crtQnty) : stockItem.quantity)}";
      await db.virtualStockBean.update(virtualStock);
      print("Increased virtual stock");
    }
    await getDBData();
  }

  Future subtractStockPointStock(StockItem stockItem, int supplierId) async {
    var stockPointStock =
        await db.stockpointStockLevelBean.find(stockItem.productId);
    if (stockPointStock != null) {
      stockPointStock.quantity =
          "${int.parse(stockPointStock.quantity) - stockItem.quantity}";
      await db.stockpointStockLevelBean.update(stockPointStock);
    } else {
      var stockPointStock = StockpointStockLevel(
        productDesc:
            commonsManager.productById(stockItem.productId)?.productDesc,
        quantity: "${stockItem.quantity}",
        category:
            commonsManager.productById(stockItem.productId).productCategory,
        productId: stockItem.productId,
        storeId: supplierId,
      );
      await db.stockpointStockLevelBean.insert(stockPointStock);
    }
    await getDBData();
  }

  Future addStockPointStock(StockItem stockItem, int supplierId) async {
    var stockPointStock =
        await db.stockpointStockLevelBean.find(stockItem.productId);
    if (stockPointStock != null) {
      stockPointStock.quantity =
          "${int.parse(stockPointStock.quantity) + stockItem.quantity}";
      await db.stockpointStockLevelBean.update(stockPointStock);
    } else {
      var stockPointStock = StockpointStockLevel(
        productDesc:
            commonsManager.productById(stockItem.productId)?.productDesc,
        quantity: "${stockItem.quantity}",
        category:
            commonsManager.productById(stockItem.productId).productCategory,
        productId: stockItem.productId,
        storeId: supplierId,
      );
      await db.stockpointStockLevelBean.insert(stockPointStock);
    }
    await getDBData();
  }

  Future _saveStockLocally(payload) async {
    List<ReceivedGood> receivedGoods = [];
    for (var item in payload) {
      receivedGoods.add(ReceivedGood.fromMap(item));
    }

    for (var item in receivedGoods) {
      await db.stockBean.insert(Stock(
        id: item.receivingId,
        totalCost: item.totalCost,
        comment: item.comment,
        entryTime: item.receivingTime?.toIso8601String(),
        paymentMethod: item.paymentType ?? "",
        entryType: item.entryType,
        photo: item.file,
        reference: item.reference ?? "",
        supplierId: item.supplierId,
        salerId: item.employeeId,
        longitude: item.lon,
        latitude: item.lat,
        synced: true,
      )..fromServer = true);
      item.receivedDetails.forEach((detail) async {
        await db.stockItemBean.insert(
          StockItem(
            stockId: detail.receivingId,
            productId: detail.productId,
            unit: detail.productPackaging,
            crtQnty: commonsManager.productById(detail.productId)?.crtQnty,
            productName:
                commonsManager.productById(detail.productId)?.productName,
            quantity: double.parse("${detail.quantityPurchased}").toInt(),
            price: double.parse("${detail.unitPrice ?? 0}"),
            productDesc:
                commonsManager.productById(detail.productId)?.productDesc,
          ),
        );
      });
    }
    print("Stock inserted");
    await getDBData();
  }

  Future _saveVirtualStockLocally(payload) async {
    await db.virtualStockBean.removeAll();
    List<Inventory> inventory = [];
    for (var item in payload) {
      inventory.add(Inventory.fromMap(item));
    }
    var products = await db.productBean.getAll();
    for (var item in inventory) {
      Product product = products.firstWhere(
          (product) => product.productId == item.productId,
          orElse: () => null);
      if (product != null) {
        if (double.parse("${item.quantity}") > 0) {
          await db.virtualStockBean.insert(VirtualStock(
            storeId: item.storeId,
            batchnumber: item.batchnumber,
            category: "${product.productCategory}",
            productId: product.productId,
            productDesc: product.productDesc,
            quantity: item.quantity,
          ));
        }
      }
    }
    print("Virtual Stock saved");
    await getDBData();
  }

  Future _saveStockPointStockLocally(payload) async {
    await db.stockpointStockLevelBean.removeAll();
    List<Inventory> inventory = [];
    for (var item in payload) {
      inventory.add(Inventory.fromMap(item));
    }
    var products = await db.productBean?.getAll();
    for (var item in inventory) {
      Product product = products.firstWhere(
          (product) => product.productId == item.productId,
          orElse: () => null);
      if (product != null) {
        if (double.parse("${item.quantity}") > 0) {
          await db.stockpointStockLevelBean.insert(StockpointStockLevel(
            storeId: item.storeId,
            category: "${product.productCategory}",
            productId: product.productId,
            productDesc: product.productDesc,
            quantity: item.quantity,
          ));
        }
      }
    }
    print("Stockpoint Stock saved");
    await getDBData();
  }

  Future syncStocks() async {
    List<Stock> unsyncedStocks =
        stocks.where((stock) => stock.synced == false).toList();
    for (Stock stock in unsyncedStocks) {
      try {
        var response =
            await api.saveInventory(await _buildStockSyncPayload(stock));
        if (response.data["status"] == 1) {
          _onSyncResponse(response.data, stock);
        } else {
          throw DioError(
            response: response,
          );
        }
      } catch (e) {
        _onSyncError(e);
      }
    }
  }

  _onSyncResponse(data, Stock stock) {
    db.stockBean.update(stock..synced = true);
    getDBData();
  }

  _onSyncError(error) {
    print("Error $error");
  }

  @override
  Future init() async {
    super.init();
    await getDBData();
  }
}

var inventoryManager = InventoryManager();
