import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/payment_mode.dart';

part 'payment_mode_bean.jorm.dart';

@GenBean()
class PaymentModeBean extends Bean<PaymentMode> with _PaymentModeBean {
  PaymentModeBean(Adapter adapter) : super(adapter);
  final String tableName = 'payment_modes';
}
