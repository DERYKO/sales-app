import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';

import '../models/competitor_activity.dart';

part 'competitor_activity_bean.jorm.dart';

@GenBean()
class CompetitorActivityBean extends Bean<CompetitorActivity>
    with _CompetitorActivityBean {
  CompetitorActivityBean(Adapter adapter) : super(adapter);
  final String tableName = 'competitor_activities';
}
