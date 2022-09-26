import 'package:bike_app/controllers/all_events_controller.dart';
import 'package:bike_app/controllers/new_event_controller.dart';
import 'package:bike_app/controllers/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../models/event.dart';

class FirebaseServices {
  //fetch all data from database
  fetchRecords() async {
    var allData = await FirebaseFirestore.instance.collection('Events').get();
    mapRecords(allData);
  }

  //map each item of database and convert them to list of items
  mapRecords(QuerySnapshot<Map<String, dynamic>> allData) {
    AllEventsController allEventsController = Get.find();
    var _listOfEvents = allData.docs
        .map((item) => Events(
            id: item.id,
            eventPlace: item['eventPlace'],
            eventType: item['eventType'],
            users: item['users'],
            eventName: item['eventName'],
            eventDate: item['eventDate'],
            startEvent: item['startEvent'],
            stopEvent: item['stopEvent'],
            estimatedTime: item['estimatedTime']))
        .toList();
    allEventsController.listOfEvents.value = _listOfEvents;
  }

//write data to database
  addEvent() {
    NewEventController newEventController = Get.find();
    var event = Events(
      id: id,
      eventPlace: newEventController.eventPlace.value,
      eventType: newEventController.eventType.value,
      users: {},
      eventName: newEventController.eventName.value,
      eventDate: newEventController.dateController.value.toString(),
      startEvent: newEventController.startTime.value.toString(),
      stopEvent: newEventController.stopTime.value.toString(),
      estimatedTime: newEventController.stopTime.value
          .difference(newEventController.startTime.value)
          .inMinutes,
    );
    FirebaseFirestore.instance.collection('Events').add(event.toMap());
  }

  //update data in database
  updateEventUser(eventID) {
    UserController userController = Get.find();
    var _newUserName = userController.userName.value;
    var _newUserPIN = userController.userPin.value;
    var newEventUser =
        FirebaseFirestore.instance.collection('Events').doc(eventID);

    newEventUser.update({'users.$_newUserName': _newUserPIN});
  }

  getSingleEvent(eventID) async {
    AllEventsController allEventsController = Get.find();
    var singleData = await FirebaseFirestore.instance
        .collection('Events')
        .doc(eventID)
        .get();
    if (singleData.exists) {
      Map<String, dynamic>? data = singleData.data();
      allEventsController.singleData.value = data!;
      // print(allEventsController.sinlgeData.value);
    }
  }

  deleteUser(eventID, userName) async {
    var users =
        await FirebaseFirestore.instance.collection('Events').doc(eventID);
    users.update({'users.$userName': FieldValue.delete()});
  }
}
