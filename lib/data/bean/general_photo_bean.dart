import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/general_photo.dart';

part 'general_photo_bean.jorm.dart';

@GenBean()
class GeneralPhotoBean extends Bean<GeneralPhoto> with _GeneralPhotoBean {
  GeneralPhotoBean(Adapter adapter) : super(adapter);
  final String tableName = 'generalphotos';
}
