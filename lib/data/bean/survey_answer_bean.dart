import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/survey_answer.dart';
import 'package:solutech_sat/data/models/survey_question.dart';

part 'survey_answer_bean.jorm.dart';

@GenBean()
class SurveyAnswerBean extends Bean<SurveyAnswer> with _SurveyAnswerBean {
  SurveyAnswerBean(Adapter adapter) : super(adapter);
  final String tableName = 'survey_answers';
}
