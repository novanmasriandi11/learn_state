import 'package:get/get.dart';

class SimpleCrudController extends GetxController {
  final _list = <String>[].obs;
  List<String> get list => _list;

  add(String n) {
    _list.add(n);
  }

  updateItem(int index, String n) {
    _list[index] = n;
  }

  delete(int index) {
    _list.removeAt(index);
  }

  clearState() {
    Get.delete<SimpleCrudController>(force: true);
  }
}
