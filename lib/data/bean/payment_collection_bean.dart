import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/payment_collection.dart';

part 'payment_collection_bean.jorm.dart';

@GenBean()
class PaymentCollectionBean extends Bean<PaymentCollection>
    with _PaymentCollectionBean {
  PaymentCollectionBean(Adapter adapter) : super(adapter);
  final String tableName = 'payment_collections';
}
