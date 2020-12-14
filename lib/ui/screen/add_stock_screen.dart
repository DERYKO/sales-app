import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:solutech_sat/bloc/add_stock_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/inventory_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/stockpoints_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/filled_dropdown_button.dart';
import 'package:solutech_sat/ui/widgets/screen_stepper.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AddStockScreen extends StatelessWidget {
  final bloc = AddStockBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Add stock",
                ),
              ),
              body: Container(
                color: Colors.grey[100],
                width: double.infinity,
                height: double.infinity,
                child: ScreenStepper(
                  currentScreen: bloc.currentScreen,
                  screens: <Widget>[
                    Column(
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            child: SingleChildScrollView(
                              controller: bloc.scrollController,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 10.0),
                                    color: Colors.grey[200],
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            "Product",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: 50.0,
                                            child: Text(
                                              "Qty",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: 60.0,
                                            child: Text(
                                              "Price",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ...bloc.stockList.map<Widget>((stockItem) {
                                    var index =
                                        bloc.stockList.indexOf(stockItem);

                                    return Slidable(
                                      delegate: SlidableDrawerDelegate(
                                        fastThreshold: 2.0,
                                      ),
                                      actionExtentRatio: 0.25,
                                      child: Container(
                                        padding: EdgeInsets.all(5.0),
                                        color: ((index + 1) % 2 == 0)
                                            ? Colors.grey[200]
                                            : Colors.white,
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    "${stockItem.productDesc}",
                                                  ),
                                                  Text(
                                                    "${stockItem.batchnumber}",
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Container(
                                                width: 50.0,
                                                child: Text(
                                                  "${stockItem.quantity} ${stockItem.unit}",
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Container(
                                                width: 60.0,
                                                child: AutoSizeText(
                                                  double.parse(
                                                          "${stockItem.price * stockItem.quantity}")
                                                      .toStringAsFixed(2),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      secondaryActions: <Widget>[
                                        IconSlideAction(
                                          caption: 'Delete',
                                          color: Colors.red,
                                          icon: Icons.delete_forever,
                                          onTap: () => bloc.onDeleteItem(index),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                  if (bloc.stockList.length > 0)
                                    Container(
                                      padding: EdgeInsets.all(5.0),
                                      color: Colors.white,
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              "TOTAL",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 60.0,
                                              child: AutoSizeText(
                                                "${bloc.stockListTotal()}",
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    if (roleManager
                                        .hasRole(Roles.REQUISITION_STOCK))
                                      RadioItem(
                                        value: "Requisition",
                                        groupValue: bloc.mode,
                                        onChanged: bloc.onModeChange,
                                        title: Text(
                                          'Requisition',
                                        ),
                                      ),
                                    if (roleManager
                                        .hasRole(Roles.ALLOW_UPLIFTS))
                                      RadioItem(
                                        value: "New Stock",
                                        groupValue: bloc.mode,
                                        onChanged: bloc.onModeChange,
                                        title: Text(
                                          'Uplifts',
                                        ),
                                      ),
                                    if (roleManager.hasRole(Roles.RETURNS))
                                      RadioItem(
                                        value: "Return Stock",
                                        groupValue: bloc.mode,
                                        onChanged: bloc.onModeChange,
                                        title: Text(
                                          "Returns",
                                        ),
                                      ),
                                    /*RadioItem(
                                    value: "transfer",
                                    groupValue: bloc.mode,
                                    onChanged: bloc.onModeChange,
                                    title: Text(
                                      'Transfer',
                                    ),
                                  ),*/
                                  ],
                                ),
                              ),
                              StreamBuilder(
                                  stream: stockPointsManager.stream,
                                  builder: (context, snapshot) {
                                    return FilledDropdownButton(
                                      isDense: true,
                                      value: bloc.stockpoint,
                                      label: "Stock point",
                                      hint: "Select stockpoint",
                                      padding: EdgeInsets.only(bottom: 5.0),
                                      items: stockPointsManager.stockPoints
                                          .map((stockpoint) {
                                        return DropdownMenuItem(
                                          child: Text("${stockpoint.shopName}"),
                                          value: stockpoint,
                                        );
                                      }).toList(),
                                      onChange: (value) {
                                        bloc.onStockpointChanged(value);
                                      },
                                    );
                                  }),
                              StreamBuilder(
                                stream: commonsManager.stream,
                                builder: (context, snapshot) {
                                  return FilledDropdownButton(
                                    isDense: true,
                                    value: bloc.productCategory,
                                    label: "Category",
                                    hint: "Select category",
                                    onTap: bloc.selectProductCategory,
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    items: (roleManager.hasRole(
                                      Roles.VIRTUAL_WITH_STOCKPOINT,
                                    ))
                                        ? inventoryManager
                                            .stockPointStockCategories(
                                                bloc.stockpoint?.id ?? 0)
                                            .map((category) {
                                            return DropdownMenuItem(
                                              child: Text("$category"),
                                              value: category,
                                            );
                                          }).toList()
                                        : commonsManager.productCategories
                                            .map((category) {
                                            return DropdownMenuItem(
                                              child: Text("$category"),
                                              value: category,
                                            );
                                          }).toList(),
                                    onChange: (value) {
                                      bloc.onCategoryChanged(value);
                                    },
                                  );
                                },
                              ),
                              FilledDropdownButton(
                                isDense: true,
                                value: bloc.product,
                                label: "Product",
                                onTap: bloc.selectProduct,
                                hint: "Select product",
                                padding: EdgeInsets.only(bottom: 5.0),
                                items: bloc.products.map((product) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      "${product.productDesc}",
                                    ),
                                    value: product,
                                  );
                                }).toList(),
                                onChange: (value) {
                                  bloc.onProductChanged(value);
                                },
                              ),
                              if (bloc.mode != "Requisition")
                                Container(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: TextFormField(
                                    controller: bloc.batchnumberCtrl,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelText: "Batch number",
                                      hintText: "Enter batch number",
                                      filled: true,
                                    ),
                                  ),
                                ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      controller: bloc.quantityCtrl,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        WhitelistingTextInputFormatter
                                            .digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelText: "Quantity",
                                        hintText: "quantity",
                                        filled: true,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 5.0,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: FilledDropdownButton(
                                      isDense: true,
                                      value: bloc.packagingOption,
                                      label: "Unit",
                                      hint: "Unit",
                                      items: commonsManager.packagingOptions
                                          .map((unit) {
                                        return DropdownMenuItem(
                                          child: Text(
                                            "${unit.packageName}",
                                          ),
                                          value: unit,
                                        );
                                      }).toList(),
                                      onChange: (value) {
                                        bloc.onUnitChange(value);
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 5.0,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      controller: bloc.priceCtrl,
                                      keyboardType: TextInputType.number,
                                      enabled: !roleManager.hasRole(
                                          Roles.DISABLE_CHANGING_BUYING_PRICE),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelText: "Price",
                                        hintText: "Buying price",
                                        filled: true,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (bloc.product != null &&
                                  roleManager
                                      .hasRole(Roles.VIRTUAL_WITH_STOCKPOINT))
                                Container(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                    "Available at stockpoint ${inventoryManager.stockPointStockLevel(bloc.product?.productId ?? 0)}",
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: MaterialButton(
                                  onPressed: bloc.addOrUpdateProduct,
                                  height: 48.0,
                                  minWidth: double.infinity,
                                  color: Theme.of(context).primaryColor,
                                  child: Text(
                                    "${bloc.addButtonText}",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      child: Container(
                        color: Colors.grey[100],
                        child: Column(
                          children: <Widget>[
                            Card(
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                color: Colors.white,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 30.0,
                                      color: Colors.white,
                                      margin: EdgeInsets.only(
                                          bottom: 10.0, top: 10.0),
                                      child: Center(
                                        child: Text(
                                          "${authManager.user.country?.currencyCode} ${bloc.stockListTotal()}",
                                          style: TextStyle(
                                            fontSize: 28.0,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                    /*Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: TextFormField(
                                            controller: bloc.totalPriceCtrl,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              labelText: "Price",
                                              hintText: "Selling price",
                                              filled: true,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 5.0,
                                        ),
                                        Expanded(
                                          child: FilledDropdownButton(
                                            isDense: true,
                                            value: bloc.paymentMethod,
                                            label: "Payment method",
                                            hint: "Payment",
                                            items: bloc.paymentMethods
                                                .map((productType) {
                                              return DropdownMenuItem(
                                                child: Text("${productType}"),
                                                value: productType,
                                              );
                                            }).toList(),
                                            onChange: (value) {
                                              bloc.onPaymentMethodChanged(
                                                  value);
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    if (bloc.paymentMethod != "Cash")
                                      Container(
                                        padding: EdgeInsets.only(top: 10.0),
                                        child: TextFormField(
                                          controller: bloc.referenceCtrl,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            labelText: "Payment reference",
                                            hintText: "Selling price",
                                            filled: true,
                                          ),
                                        ),
                                      ),
                                    if (bloc.paymentMethod == "Cheque")
                                      Container(
                                        padding: EdgeInsets.only(top: 10.0),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              isDense: true,
                                              labelText: "Maturity date",
                                              hintText: "Maturity",
                                              filled: true,
                                              suffixIcon:
                                                  Icon(Icons.calendar_today)),
                                        ),
                                      ),
                                      */
                                    Container(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: bloc.takePhoto,
                                            child: Container(
                                              height: 97.0,
                                              width: 97.0,
                                              color: Colors.grey[100],
                                              child: (bloc.image != null)
                                                  ? Image.file(
                                                      bloc.image,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Icon(
                                                      Icons.camera_alt,
                                                      size: 30.0,
                                                    ),
                                            ),
                                          ),
                                          Container(
                                            width: 5.0,
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 100.0,
                                              child: TextFormField(
                                                controller: bloc.commentCtrl,
                                                maxLines: 3,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  labelText: "Comments",
                                                  hintText: "Enter comments",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                  onNext: bloc.nextScreen,
                  onPrev: bloc.prevScreen,
                  onSave: bloc.saveStockItems,
                ),
              ),
            );
          }),
    );
  }
}

class RadioItem<T> extends StatelessWidget {
  Widget title;
  T value;
  T groupValue;
  Color activeColor;
  ValueChanged<T> onChanged;
  MaterialTapTargetSize materialTapTargetSize;
  RadioItem({
    this.title,
    @required this.value,
    @required this.groupValue,
    @required this.onChanged,
    this.activeColor,
    this.materialTapTargetSize,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: Row(
        children: <Widget>[
          Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: activeColor,
            materialTapTargetSize: materialTapTargetSize,
          ),
          title,
        ],
      ),
    );
  }
}
