import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/payment.dart';

part 'payment_bean.jorm.dart';

@GenBean()
class PaymentBean extends Bean<Payment> with _PaymentBean {
  PaymentBean(Adapter adapter) : super(adapter);
  final String tableName = 'payments';
}
