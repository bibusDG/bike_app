import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../models/event.dart';

class AllEventsController extends GetxController {
  var listOfEvents = <Events>[].obs;
  RxString eventID = ''.obs;
  var singleData = <String, dynamic>{}.obs;
}
