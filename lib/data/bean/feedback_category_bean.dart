import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/feedback_category.dart';

part 'feedback_category_bean.jorm.dart';

@GenBean()
class FeedbackCategoryBean extends Bean<FeedbackCategory>
    with _FeedbackCategoryBean {
  FeedbackCategoryBean(Adapter adapter) : super(adapter);
  final String tableName = 'feedback_categories';
}
