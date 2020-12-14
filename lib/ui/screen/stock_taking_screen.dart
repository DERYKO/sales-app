import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:solutech_sat/bloc/add_stock_bloc.dart';
import 'package:solutech_sat/bloc/sale_order_bloc.dart';
import 'package:solutech_sat/bloc/stock_taking_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/route_plan.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/inventory_manager.dart';
import 'package:solutech_sat/helpers/payments_manager.dart';
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

class StockTakingScreen extends StatelessWidget {
  StockTakingBloc bloc;
  StockTakingScreen({
    @required RoutePlan routePlan,
    @required Customer customer,
  }) {
    bloc = StockTakingBloc(routePlan: routePlan, customer: customer);
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
                          child: Text("${roleManager.resolveTitle(
                            title: "STOCK TAKING",
                            module: Roles.STOCK_TAKING,
                            capitalize: true,
                          )}"),
                        ),
                        Text(
                          "${bloc.customer.shopName.toUpperCase()}",
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Center(
                          child: InkResponse(
                            onTap: bloc.saveStockTake,
                            child: Text(
                              "SAVE",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  body: Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                    child: SingleChildScrollView(
                                      controller: bloc.scrollController,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding:
                                                EdgeInsets.only(left: 10.0),
                                            color: Colors.grey[200],
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                    "Product",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          ...bloc.stockTakeItems
                                              .map<Widget>((stockItem) {
                                            var index = bloc.stockTakeItems
                                                .indexOf(stockItem);
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
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        width: 50.0,
                                                        child: Text(
                                                          "${stockItem.quantity} ${stockItem.packaging}",
                                                          textAlign:
                                                              TextAlign.end,
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
                                      StreamBuilder(
                                        stream: commonsManager.stream,
                                        builder: (context, snapshot) {
                                          return FilledDropdownButton(
                                            isDense: true,
                                            value: bloc.productCategory,
                                            label: "Category",
                                            hint: "Select category",
                                            onTap: bloc.selectProductCategory,
                                            padding:
                                                EdgeInsets.only(bottom: 5.0),
                                            items: commonsManager
                                                .productCategories
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
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 2,
                                            child: TextFormField(
                                              controller: bloc.quantityCtrl,
                                              keyboardType:
                                                  TextInputType.number,
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
                                              items: commonsManager
                                                  .packagingOptions
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
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 5.0),
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
                          ),
                          Footer(),
                        ],
                      )),
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
