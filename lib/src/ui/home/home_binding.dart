import 'package:flutter_formation/src/ui/home/home_controller.dart';
import 'package:get/instance_manager.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(city: 'Tunisia'));
  }
}
