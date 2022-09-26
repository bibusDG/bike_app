// ignore_for_file: prefer_const_constructors, unused_local_variable
import 'package:bike_app/controllers/new_event_controller.dart';
import 'package:bike_app/controllers/user_controller.dart';
import 'package:bike_app/models/users.dart';
import 'package:bike_app/services/firebase_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

List<String> eventType = ['Trening', 'Zawody', 'Relaks', 'Las', 'Szosa'];
int _evenTypeValue = 0;

class NewEvent extends StatelessWidget {
  const NewEvent({super.key});
  @override
  Widget build(BuildContext context) {
    NewEventController newEventController = Get.put(NewEventController());
    UserController userController = Get.put(UserController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Utwórz nowe wydarzenie')),
        body: Column(
          children: [
            SizedBox(
              height: 40.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SizedBox(
                  width: 300.0,
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        helperText: 'Nazwa'),
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    onChanged: (value) {
                      newEventController.eventName.value = value;
                    },
                  ),
                ),
              ),
            ),
            Obx(
              () => Card(
                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.0),
                    borderRadius: BorderRadius.circular(20.0)),
                child: SizedBox(
                  width: 300.0,
                  height: 120.0,
                  child: ScrollDatePicker(
                    minimumDate: DateTime.now(),
                    maximumDate: DateTime.utc(2050),
                    selectedDate: newEventController.dateController.value,
                    locale: Locale('pl'),
                    onDateTimeChanged: (DateTime value) {
                      {
                        newEventController.dateController.value = value;
                      }
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
              child: Text('Data wydarzenia'),
            ),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 150.0,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyClockWidget(
                      newEventController: newEventController,
                      clockName: 'startClock',
                      underName: 'Start',
                    ),
                    MyClockWidget(
                      newEventController: newEventController,
                      clockName: 'stopClock',
                      underName: 'Stop',
                    )
                  ]),
            ),
            SizedBox(),
            SizedBox(
              width: 300.0,
              height: 100.0,
              child: CupertinoPicker(
                itemExtent: 32.0,
                onSelectedItemChanged: (selectedItem) {
                  _evenTypeValue = selectedItem;
                  newEventController.eventType.value =
                      eventType[_evenTypeValue];
                },
                children: List<Widget>.generate(eventType.length, (int index) {
                  return Center(
                    child: Text(
                      eventType[index],
                    ),
                  );
                }),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: 300.0,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    helperText: 'Miejsce zbiórki'),
                keyboardType: TextInputType.text,
                maxLines: 1,
                onChanged: (value) {
                  newEventController.eventPlace.value = value;
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
                onPressed: () {
                  FirebaseServices().addEvent();
                  Get.back();
                },
                child: Text('Dodaj wydarzenie')),
          ],
        ),
      ),
    );
  }
}

class MyClockWidget extends StatelessWidget {
  const MyClockWidget({
    Key? key,
    required this.underName,
    required this.newEventController,
    required this.clockName,
  }) : super(key: key);

  final NewEventController newEventController;
  final String clockName;
  final String underName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
              side: BorderSide(width: 1.0),
              borderRadius: BorderRadius.circular(20.0)),
          child: SizedBox(
            width: 130.0,
            height: 100.0,
            child: TimePickerSpinner(
              minutesInterval: 5,
              is24HourMode: true,
              normalTextStyle: TextStyle(fontSize: 24, color: Colors.black12),
              highlightedTextStyle:
                  TextStyle(fontSize: 24, color: Colors.black),
              spacing: 10,
              itemHeight: 40,
              itemWidth: 40.0,
              isForce2Digits: false,
              onTimeChange: (time) {
                if (clockName == 'startClock') {
                  newEventController.startTime.value = time;
                }
                if (clockName == 'stopClock') {
                  newEventController.stopTime.value = time;
                }
              },
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(underName),
      ],
    );
  }
}
