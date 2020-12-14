import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/order.dart';
import 'package:solutech_sat/data/models/order_item.dart';
import 'package:solutech_sat/data/models/route_plan.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/shop_category.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/dialogs/contact_customer_dialog.dart';
import 'package:solutech_sat/ui/screen/add_edit_customer_screen.dart';
import 'package:solutech_sat/ui/screen/brand_audit_screen.dart';
import 'package:solutech_sat/ui/screen/etr_printing_screen.dart';
import 'package:solutech_sat/ui/screen/posm_audit_screen.dart';
import 'package:solutech_sat/ui/screen/sale_order_screen.dart';
import 'package:solutech_sat/ui/screen/skip_customer_screen.dart';

class RecentActivityBloc extends Bloc {
  String mode;
  Customer customer;
  RoutePlan routePlan;
  RecentActivityBloc({this.customer, this.routePlan, this.mode});

  void navigateForAction() {
    if (mode == "Skip") {
      skipOutlet();
    } else if (mode == "Brand") {
      navigate(
        screen: BrandAuditScreen(
          customer: customer,
        ),
      );
    } else if (mode == "Posm") {
      navigate(
        screen: PosmAuditScreen(
          customer: customer,
        ),
      );
    } else if (mode == "Sale") {
      navigate(
        screen: SaleOrderScreen(
          customer: customer,
          routePlan: routePlan,
          mode: "Sale",
        ),
      );
    } else if (mode == "Order") {
      navigate(
        screen: SaleOrderScreen(
          customer: customer,
          routePlan: routePlan,
          mode: "Order",
        ),
      );
    }
  }

  void skipOutlet() {
    navigate(
      screen: SkipCustomerScreen(
        customer: customer,
      ),
    );
  }

  void printSaleOrder(int shopId, Order order, List<OrderItem> orderItems) {
    if (order.synced) {
      navigate(
          screen: EtrPrintingScreen(
        order: order,
        orderItems: orderItems,
      ));
    } else {
      alert("Sale not synced",
          "You will be able to print once the sale is synced.");
    }
  }

  void makeAnOrder() {
    navigate(
      screen: SaleOrderScreen(
        customer: customer,
        routePlan: routePlan,
        mode: "Order",
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
