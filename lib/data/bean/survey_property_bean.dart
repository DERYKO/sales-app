import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/survey_property.dart';

part 'survey_property_bean.jorm.dart';

@GenBean()
class SurveyPropertyBean extends Bean<SurveyProperty> with _SurveyPropertyBean {
  SurveyPropertyBean(Adapter adapter) : super(adapter);
  final String tableName = 'survey_properties';
}
