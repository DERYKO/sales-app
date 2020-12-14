import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solutech_sat/bloc/add_competition_bloc.dart';
import 'package:solutech_sat/bloc/add_product_uptate_bloc.dart';
import 'package:solutech_sat/bloc/add_sos_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/helpers/brands_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/csku_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/sos_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/filled_dropdown_button.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';

class AddSosScreen extends StatelessWidget {
  AddSosBloc bloc;
  AddSosScreen({Customer customer}) : bloc = AddSosBloc(customer: customer);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            return Scaffold(
              appBar: AppBar(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FittedBox(
                      child: Text("${roleManager.resolveTitle(
                        title: "SHARE OF SHELF",
                        module: Roles.SHELF_SHARE,
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
                bottom: (bloc.customer != null)
                    ? PreferredSize(
                        child: Container(
                          height: 40.0,
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              left: 72.0, bottom: 10.0, right: 17.0),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "${bloc.customer.shopName}",
                            style:
                                TextStyle(fontSize: 17.0, color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white.withAlpha(30),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0))),
                        ),
                        preferredSize: Size(double.infinity, 50),
                      )
                    : null,
              ),
              body: Container(
                color: Colors.white,
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                          itemCount: brandsManager.categories.length,
                          itemBuilder: (context, index) {
                            String category = brandsManager.categories[index];
                            return GestureDetector(
                              onTap: () => bloc.auditSos(category),
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                height: 50.0,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        "$category",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                    if (sosManager.hasTodaysRecordForCategory(
                                        bloc.customer.id, category))
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: 16.0,
                                      ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey[100],
                                      ),
                                    ),
                                    color: (index + 1) % 2 == 0
                                        ? Colors.grey[200]
                                        : Colors.white),
                              ),
                            );
                          }),
                    ),
                    Footer(),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
