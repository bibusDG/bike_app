import 'package:bike_app/models/users.dart';
import 'package:get/get.dart';

class NewEventController extends GetxController {
  RxString eventName = ''.obs;
  Rx<DateTime> dateController = DateTime.now().obs;
  Rx<DateTime> startTime = DateTime.now().obs;
  Rx<DateTime> stopTime = DateTime.now().obs;
  RxString eventType = 'Trening'.obs;
  RxString eventPlace = ''.obs;
}
