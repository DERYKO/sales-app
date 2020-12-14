import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/photo.dart';

part 'photo_bean.jorm.dart';

@GenBean()
class PhotoBean extends Bean<Photo> with _PhotoBean {
  PhotoBean(Adapter adapter) : super(adapter);
  final String tableName = 'photos';
}
