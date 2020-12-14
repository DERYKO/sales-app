import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solutech_sat/bloc/add_competition_bloc.dart';
import 'package:solutech_sat/bloc/add_product_uptate_bloc.dart';
import 'package:solutech_sat/bloc/etr_printer_bloc.dart';
import 'package:solutech_sat/bloc/etr_printing_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/order.dart';
import 'package:solutech_sat/data/models/order_item.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/bluetooth_manager.dart';
import 'package:solutech_sat/helpers/brands_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/csku_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/custom_expansion_tile.dart';
import 'package:solutech_sat/ui/widgets/filled_dropdown_button.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/utils/device_utils.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class EtrPrinterScreen extends StatelessWidget {
  EtrPrinterBloc bloc;

  EtrPrinterScreen() : bloc = EtrPrinterBloc();
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
                  "ETR Printer",
                ),
              ),
              body: Container(
                color: Colors.white,
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: StreamBuilder(
                            stream: bluetoothManager.stream,
                            builder: (context, snapshot) {
                              return (bluetoothManager.isEnabled)
                                  ? ListView(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(10.0),
                                          width: double.infinity,
                                          child: (bluetoothManager
                                                      .bluetoothDevice ==
                                                  null)
                                              ? Center(
                                                  child: Text(
                                                    "SELECT PRINTER",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  child: Column(
                                                    children: <Widget>[
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                          bottom: 10.0,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Text(
                                                              "Device: ",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              "${bluetoothManager.bluetoothDevice.name ?? bluetoothManager.bluetoothDevice.address}",
                                                              style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          InkResponse(
                                                            onTap:
                                                                bloc.generateZ,
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                Icon(Icons
                                                                    .local_printshop),
                                                                Text("Z-Report")
                                                              ],
                                                            ),
                                                          ),
                                                          InkResponse(
                                                            onTap: bloc
                                                                .resetPrinter,
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                Icon(Icons
                                                                    .restore),
                                                                Text(
                                                                    "Reset printer")
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                offset: Offset(1, 1),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (!bluetoothManager.connectedToDevice)
                                          Column(
                                            children: <Widget>[
                                              ...bluetoothManager.scannedDevices
                                                  .map((device) {
                                                var index = bluetoothManager
                                                    .scannedDevices
                                                    .indexOf(device);
                                                return Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.all(10.0)
                                                      .copyWith(
                                                          top: 0.0,
                                                          bottom: 0.0),
                                                  color: (index + 1) % 2 == 0
                                                      ? Colors.grey[100]
                                                      : Colors.white,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                        "${device.name != "" ? device.name : device.address}",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      MaterialButton(
                                                        height: 30.0,
                                                        child: Text(
                                                          "SELECT",
                                                          style: TextStyle(
                                                            color: (!bluetoothManager
                                                                    .isConnecting)
                                                                ? Colors.white
                                                                : Colors.grey,
                                                          ),
                                                        ),
                                                        color: Colors.green,
                                                        textColor: Colors.white,
                                                        onPressed: () =>
                                                            bloc.selectDevice(
                                                          device,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }).toList()
                                            ],
                                          ),
                                      ],
                                    )
                                  : Container(
                                      padding: EdgeInsets.only(
                                          left: 20.0, right: 20.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.bluetooth,
                                            size: 80.0,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text(
                                              "BLUETOOTH DISABLED",
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "Make sure you have enabled bluetooth to continue.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 8.0),
                                            child: MaterialButton(
                                              onPressed: bluetoothManager
                                                  .enableBluetooth,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              textColor: Colors.white,
                                              child: Text(
                                                "ENABLE BLUETOOTH",
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                            })),
                    Footer(),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
