import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/posm_material.dart';

part 'posm_material_bean.jorm.dart';

@GenBean()
class PosmMaterialBean extends Bean<PosmMaterial> with _PosmMaterialBean {
  PosmMaterialBean(Adapter adapter) : super(adapter);
  final String tableName = 'posm_materials';
}
