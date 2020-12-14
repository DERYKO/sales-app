import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/feedback.dart';

part 'feedback_bean.jorm.dart';

@GenBean()
class FeedbackBean extends Bean<Feedback> with _FeedbackBean {
  FeedbackBean(Adapter adapter) : super(adapter);
  final String tableName = 'feedbacks';
}
