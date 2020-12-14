import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/packaging_option.dart';

part 'packaging_option_bean.jorm.dart';

@GenBean()
class PackagingOptionBean extends Bean<PackagingOption>
    with _PackagingOptionBean {
  PackagingOptionBean(Adapter adapter) : super(adapter);
  final String tableName = 'packaging_options';
}
