
import 'package:get/get.dart';
import 'LanguageController.dart';

class LanguageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LanguageController());
  }
}