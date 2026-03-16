import 'package:get/get.dart';

class SubTestModel {
  final String id;
  final String code;
  final String title;
  final String subtitle;
  final RxInt price;
  final RxBool isSelected;

  SubTestModel(this.id, this.code, this.title, this.subtitle, int p, bool sel)
      : price = p.obs,
        isSelected = sel.obs;
}
