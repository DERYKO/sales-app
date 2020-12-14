import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:solutech_sat/bloc/add_stock_bloc.dart';
import 'package:solutech_sat/bloc/sale_order_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/route_plan.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/inventory_manager.dart';
import 'package:solutech_sat/helpers/payments_manager.dart';
import 'package:solutech_sat/helpers/promotions_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/stockpoints_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/filled_dropdown_button.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/ui/widgets/screen.dart';
import 'package:solutech_sat/ui/widgets/screen_stepper.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SaleOrderScreen extends StatelessWidget {
  SaleOrderBloc bloc;
  SaleOrderScreen({
    @required RoutePlan routePlan,
    @required Customer customer,
    @required String mode,
  }) {
    bloc = SaleOrderBloc(routePlan: routePlan, customer: customer, mode: mode);
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            return WillPopScope(
                child: Scaffold(
                  appBar: AppBar(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FittedBox(
                          child: Text("${bloc.mode?.toUpperCase()}"),
                        ),
                        Text(
                          "${bloc.customer.shopName.toUpperCase()}",
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  body: Container(
                    color: Colors.white,
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                            )
                                          ],
                                        ),
                                      ),
                                      ...bloc.orderList
                                          .map<Widget>((stockItem) {
                                        var index =
                                            bloc.orderList.indexOf(stockItem);
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        "${commonsManager.productById(stockItem.productId)?.productDesc}",
                                                      ),
                                                      if (stockItem
                                                                  .batchnumber !=
                                                              null &&
                                                          stockItem
                                                                  .batchnumber !=
                                                              "")
                                                        RichText(
                                                          text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      "Batch:",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        11.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                    text: " "),
                                                                TextSpan(
                                                                  text:
                                                                      "${stockItem.batchnumber}",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        11.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .black54,
                                                                  ),
                                                                ),
                                                              ]),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width: 50.0,
                                                    child: Text(
                                                      "${stockItem.quantity} ${stockItem.productPackaging}",
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width: 60.0,
                                                    child: AutoSizeText(
                                                      double.parse(
                                                        "${double.parse(stockItem.sellingPrice) * stockItem.quantity}",
                                                      ).toStringAsFixed(2),
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          secondaryActions: <Widget>[
                                            IconSlideAction(
                                              caption: "Delete",
                                              color: Colors.red,
                                              icon: Icons.delete_forever,
                                              onTap: () =>
                                                  bloc.onDeleteItem(index),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                      if (bloc.orderList.length > 0)
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
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
                                        ),
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
                                  if (bloc.mode == "Order")
                                    Container(
                                      padding: EdgeInsets.only(bottom: 5.0),
                                      child: Stack(
                                        children: <Widget>[
                                          TextFormField(
                                            controller: bloc.deliveryDateCtrl,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              filled: true,
                                              labelText: "Delivery date",
                                              hintText: "Select delivery date",
                                              suffixIcon: Icon(
                                                Icons.date_range,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: bloc.pickDeliveryDate,
                                            child: Container(
                                              color: Colors.transparent,
                                              height: 50.0,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  if (bloc.mode == "Order" &&
                                      sessionManager.inSession)
                                    FilledDropdownButton(
                                      isDense: true,
                                      value: bloc.orderChannel,
                                      label: "Channel",
                                      hint: "Select channel",
                                      padding: EdgeInsets.only(bottom: 5.0),
                                      items: ["Physical Visit", "Call"]
                                          .map((channel) {
                                        return DropdownMenuItem(
                                          child: Text("$channel"),
                                          value: channel,
                                        );
                                      }).toList(),
                                      onChange: (value) {
                                        bloc.onChannelChanged(value);
                                      },
                                    ),
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
                                        items: ((bloc.mode == "Sale")
                                                ? inventoryManager
                                                    .virtualStockCategories
                                                : commonsManager
                                                    .productCategories)
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
                                    onTap: (bloc.mode == "Order")
                                        ? bloc.selectProduct
                                        : bloc.selectProductInStock,
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
                                          enabled: !roleManager.hasRole(Roles
                                              .DISABLE_CHANGING_SELLING_PRICE),
                                          decoration: InputDecoration(
                                            isDense: true,
                                            labelText: "Price",
                                            hintText: "Selling price",
                                            filled: true,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (bloc.product != null &&
                                      bloc.mode == "Sale")
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0)
                                            .copyWith(bottom: 0.0),
                                        child: Text(
                                          "Available in stock ${bloc.availableInStock(
                                            bloc.virtualStock,
                                          )} pcs",
                                          style: TextStyle(
                                            color: bloc.availableInStock(
                                                        bloc.virtualStock) >
                                                    0
                                                ? Theme.of(context).accentColor
                                                : Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (roleManager.hasRole(Roles.INITIATIVES) &&
                                      bloc.product != null &&
                                      bloc.mode == "Sale" &&
                                      promotionsManager.promotionFor(
                                              bloc.product.productId) !=
                                          null)
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0)
                                            .copyWith(bottom: 0.0),
                                        child: Text(
                                          "Promotion: ${promotionsManager.promotionFor(bloc.product.productId).description}",
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (roleManager.hasRole(Roles.INITIATIVES) &&
                                      bloc.currentIncentive() != null)
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0)
                                            .copyWith(bottom: 0.0),
                                        child: Text(
                                          "Give the customer  ${bloc.currentIncentive()[2]} ${promotionsManager.freeInitiativesFor(promotionsManager.promotionFor(bloc.orderList[bloc.currentIncentive()[0]].productId)?.id).map((freeItem) => commonsManager.productById(freeItem.freeProduct)?.productDesc).toList().join(" or ")}",
                                          style: TextStyle(
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: MaterialButton(
                                      onPressed:
                                          (bloc.currentIncentive() != null)
                                              ? bloc.addIncentive
                                              : bloc.addOrUpdateProduct,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        FilledDropdownButton(
                                          isDense: true,
                                          value: bloc.paymentMode,
                                          label: "Payment mode",
                                          hint: "Payment",
                                          items: commonsManager.paymentModes
                                              .map((payment) {
                                            return DropdownMenuItem(
                                              child: Text(
                                                  "${payment.paymentMode}"),
                                              value: payment,
                                            );
                                          }).toList(),
                                          onChange: (value) {
                                            bloc.onPaymentModeChanged(value);
                                          },
                                        ),
                                        if (bloc.paymentMode?.slug != "credit")
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                            child: TextFormField(
                                              controller: bloc.totalPriceCtrl,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                labelText: "Amount paid",
                                                hintText: "Amount paid",
                                                filled: true,
                                              ),
                                            ),
                                          ),
                                        if ((bloc.totalPriceCtrl.text.trim() !=
                                                    "" &&
                                                (double.parse(
                                                        "${bloc.totalPriceCtrl.text}") <
                                                    double.parse(
                                                        "${bloc.stockListTotal()}"))) ||
                                            bloc.paymentMode?.slug == "credit")
                                          Column(
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.all(10.0),
                                                child: Row(
                                                  children: <Widget>[
                                                    Text(
                                                      "Balance",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                        left: 5.0,
                                                      ),
                                                      child: Text(
                                                          "${double.parse("${bloc.stockListTotal()}") - double.parse("${bloc.totalPriceCtrl.text.trim() != "" ? bloc.totalPriceCtrl.text : 0}")}"),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    bottom: 5.0),
                                                child: Stack(
                                                  children: <Widget>[
                                                    TextFormField(
                                                      controller: bloc
                                                          .nextPaymentDateCtrl,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        filled: true,
                                                        labelText:
                                                            "Next payment",
                                                        hintText:
                                                            "Select next payment",
                                                        suffixIcon: Icon(
                                                          Icons.date_range,
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: bloc
                                                          .pickNextPaymentDate,
                                                      child: Container(
                                                        color:
                                                            Colors.transparent,
                                                        height: 50.0,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        if (bloc.paymentMode?.slug != "cash" &&
                                            bloc.paymentMode?.slug != "credit")
                                          Container(
                                            padding: EdgeInsets.only(top: 5.0),
                                            child: StreamBuilder(
                                                stream: paymentsManager.stream,
                                                builder: (context, snapshot) {
                                                  return Stack(
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          if (paymentsManager
                                                                      .mpesaPayments
                                                                      .length >
                                                                  0 ||
                                                              paymentsManager
                                                                  .loadingMpesaPayments)
                                                            Expanded(
                                                              child:
                                                                  FilledDropdownButton(
                                                                loading:
                                                                    paymentsManager
                                                                        .loadingMpesaPayments,
                                                                isDense: true,
                                                                label:
                                                                    "Payment reference",
                                                                hint:
                                                                    "Reference",
                                                                value: bloc
                                                                    .mpesaPayment,
                                                                onTap: bloc
                                                                    .pickMpesaPayment,
                                                                items: paymentsManager
                                                                    .mpesaPayments
                                                                    .map(
                                                                        (mpesaPayment) {
                                                                  return DropdownMenuItem(
                                                                    child: Text(
                                                                      "${mpesaPayment.transactionreference}",
                                                                    ),
                                                                    value:
                                                                        mpesaPayment,
                                                                  );
                                                                }).toList(),
                                                                onChange:
                                                                    (value) {
                                                                  bloc.onMpesaPaymentChanged(
                                                                      value);
                                                                },
                                                              ),
                                                            ),
                                                          if (paymentsManager
                                                                      .mpesaPayments
                                                                      .length ==
                                                                  0 &&
                                                              !paymentsManager
                                                                  .loadingMpesaPayments)
                                                            Expanded(
                                                              child:
                                                                  TextFormField(
                                                                controller: bloc
                                                                    .referenceCtrl,
                                                                decoration:
                                                                    InputDecoration(
                                                                  isDense: true,
                                                                  labelText: (bloc
                                                                              .paymentMode
                                                                              ?.slug ==
                                                                          "cheque")
                                                                      ? "Cheque Number"
                                                                      : "Payment reference",
                                                                  hintText: (bloc
                                                                              .paymentMode
                                                                              ?.slug ==
                                                                          "cheque")
                                                                      ? "Cheque number"
                                                                      : "Reference",
                                                                  filled: true,
                                                                ),
                                                              ),
                                                            ),
                                                          if (paymentsManager
                                                                      .mpesaPayments
                                                                      .length >
                                                                  0 ||
                                                              paymentsManager
                                                                  .loadingMpesaPayments)
                                                            IconButton(
                                                              onPressed: bloc
                                                                  .loadPayments,
                                                              icon: Icon(
                                                                Icons.refresh,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          if (bloc.paymentMode
                                                                  ?.slug ==
                                                              "mpesa")
                                                            IconButton(
                                                              onPressed: bloc
                                                                  .toggleReference,
                                                              icon: Icon(
                                                                Icons
                                                                    .swap_horiz,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                }),
                                          ),
                                        if (bloc.paymentMode?.slug == "cheque")
                                          Container(
                                            padding: EdgeInsets.only(top: 5.0),
                                            child: Stack(
                                              children: <Widget>[
                                                TextFormField(
                                                  controller:
                                                      bloc.maturityDateCtrl,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    filled: true,
                                                    labelText: "Maturity date",
                                                    hintText: "Cheque maturity",
                                                    suffixIcon: Icon(
                                                      Icons.date_range,
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: bloc.pickMaturityDate,
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    height: 50.0,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        if (bloc.paymentMode?.slug == "cheque")
                                          Container(
                                            margin: EdgeInsets.only(
                                              top: 5.0,
                                            ),
                                            child: GestureDetector(
                                              onTap: bloc.takePhoto,
                                              child: Container(
                                                height: (bloc.image != null)
                                                    ? 200.0
                                                    : 50.0,
                                                width: double.infinity,
                                                color: Colors.grey[100],
                                                child: Container(
                                                  child: (bloc.image != null)
                                                      ? Image.file(
                                                          bloc.image,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Icon(
                                                              Icons.camera_alt,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                "PHOTO",
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (bloc.mode == "Order")
                                          Container(
                                            padding: EdgeInsets.only(top: 10.0),
                                            child: TextFormField(
                                              controller: bloc.lpoNumberCtrl,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                filled: true,
                                                labelText: "Lpo number",
                                                hintText: "Select lpo number",
                                              ),
                                            ),
                                          ),
                                        Container(
                                          padding: EdgeInsets.only(top: 10.0),
                                          child: Row(
                                            children: <Widget>[
                                              if (bloc.mode == "Order")
                                                GestureDetector(
                                                  onTap: bloc.takePhoto,
                                                  child: Container(
                                                    height: 97.0,
                                                    width: 97.0,
                                                    margin: EdgeInsets.only(
                                                      right: 5.0,
                                                    ),
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
                                              Expanded(
                                                child: Container(
                                                  height: 100.0,
                                                  child: TextFormField(
                                                    controller: bloc.notesCtrl,
                                                    maxLines: 3,
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      labelText: "Notes",
                                                      hintText:
                                                          "Enter additional notes",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        CheckboxListTile(
                                          value: bloc.showCreditNote,
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          title: Text(
                                            "Add credit note",
                                          ),
                                          onChanged: (value) =>
                                              bloc.toggleCreditNote(),
                                        ),
                                        if (bloc.showCreditNote)
                                          Container(
                                            height: 100.0,
                                            child: TextFormField(
                                              controller: bloc.creditNoteCtrl,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                filled: true,
                                                labelText: "Credit note amount",
                                                hintText:
                                                    "Enter credit note amount",
                                              ),
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                      onNext: bloc.nextScreen,
                      onPrev: bloc.prevScreen,
                      onSave: bloc.saveOrder,
                    ),
                  ),
                ),
                onWillPop: bloc.onWillPop);
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
