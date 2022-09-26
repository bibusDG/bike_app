import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class UserController extends GetxController {
  RxString userName = ''.obs;
  RxString userPin = ''.obs;
  RxString userLogOutPin = ''.obs;
}
