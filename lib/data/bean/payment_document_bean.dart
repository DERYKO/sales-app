import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/payment_document.dart';

part 'payment_document_bean.jorm.dart';

@GenBean()
class PaymentDocumentBean extends Bean<PaymentDocument>
    with _PaymentDocumentBean {
  PaymentDocumentBean(Adapter adapter) : super(adapter);
  final String tableName = 'payment_documents';
}
