// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:bike_app/controllers/all_events_controller.dart';
import 'package:bike_app/controllers/new_event_controller.dart';
import 'package:bike_app/controllers/user_controller.dart';
import 'package:bike_app/models/users.dart';
import 'package:bike_app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    AllEventsController allEventsController = Get.find();

    // FirebaseServices().getSingleEvent(allEventsController.eventID.value);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Szczegóły wydarzenia'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 300.0,
                width: double.infinity,
                child: Card(
                  child: Column(children: [
                    Text(
                      allEventsController.singleData['eventName'].toUpperCase(),
                      style: TextStyle(
                          fontSize: 35.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      allEventsController.singleData['eventDate']
                          .substring(0, 10),
                      style: TextStyle(fontSize: 30.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.flag_outlined,
                              size: 80.0,
                            ),
                            Text(
                              allEventsController.singleData['startEvent']
                                  .substring(11, 16),
                              style: TextStyle(fontSize: 30.0),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.sports_score_outlined,
                              size: 80.0,
                            ),
                            Text(
                              allEventsController.singleData['stopEvent']
                                  .substring(11, 16),
                              style: TextStyle(fontSize: 30.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          size: 50.0,
                        ),
                        Text(
                          '${allEventsController.singleData['estimatedTime']}min',
                          style: TextStyle(fontSize: 25.0),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.pin_drop_outlined,
                          size: 50.0,
                        ),
                        Text(
                          allEventsController.singleData['eventPlace'],
                          style: TextStyle(fontSize: 25.0),
                        ),
                      ],
                    ),
                  ]),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  color: Colors.orangeAccent,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: 350.0,
                  width: double.infinity,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Events')
                        .doc(allEventsController.eventID.value)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text('loading');
                      } else {
                        var listOfUsers = snapshot.data!['users'].keys.toList();
                        return GridView.builder(
                            itemCount: listOfUsers.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1 / .3),
                            itemBuilder: (context, index) {
                              return Center(
                                  child: GestureDetector(
                                onLongPress: () {
                                  UserController userController =
                                      Get.put(UserController());
                                  Get.defaultDialog(
                                    onConfirm: () async {
                                      if (userController.userLogOutPin.value ==
                                          snapshot.data!['users']
                                              [listOfUsers[index]]) {
                                        await FirebaseServices().deleteUser(
                                            allEventsController.eventID.value,
                                            listOfUsers[index]);
                                        Get.back();
                                      } else {
                                        Get.back();
                                        Get.defaultDialog(
                                            title: 'Błąd',
                                            middleText:
                                                'Niepoprawne hasło, spróbuj jeszcze raz');
                                      }
                                    },
                                    title: 'Opuszczasz wydarzenie',
                                    content: TextField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0))),
                                          helperText: 'Podaj swoje hasło'),
                                      keyboardType: TextInputType.text,
                                      maxLines: 1,
                                      onChanged: (value) {
                                        userController.userLogOutPin.value =
                                            value;
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        // color: Colors.lightBlueAccent,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                        border: Border.all(
                                            color: Colors.black, width: 2.0)),
                                    height: 40.0,
                                    width: 190,
                                    child: Center(
                                        child: Text(
                                      listOfUsers[index],
                                      style: TextStyle(fontSize: 18.0),
                                    ))),
                              ));
                            });
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60.0))),
                      onPressed: () {
                        UserController userController =
                            Get.put(UserController());
                        Get.defaultDialog(
                          onConfirm: () async {
                            if (allEventsController.singleData['users']
                                .containsKey(userController.userName.value)) {
                              Get.back();
                              Get.defaultDialog(
                                title: 'Uwaga',
                                content: Text(
                                    'Taka osoba juz się zapisała\n spróbuj ponownie'),
                              );
                            } else {
                              await FirebaseServices().updateEventUser(
                                  allEventsController.eventID.value);
                              Get.back();
                            }
                          },
                          title: 'Dołącz do wydzarzenia',
                          content: Column(
                            children: [
                              Text('Wpisz swoje imię/ksywkę oraz hasło'),
                              SizedBox(
                                height: 20.0,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    helperText: 'Imię'),
                                keyboardType: TextInputType.text,
                                maxLines: 1,
                                onChanged: (value) {
                                  userController.userName.value = value;
                                },
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    helperText: 'Hasło'),
                                keyboardType: TextInputType.text,
                                maxLines: 1,
                                onChanged: (value) {
                                  userController.userPin.value = value;
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text(
                        'Dopisz się',
                        style: TextStyle(color: Colors.black),
                      )),
                  SizedBox(
                    width: 60.0,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60.0))),
                      onPressed: () {
                        Get.defaultDialog(
                            title: 'Informacja',
                            middleText:
                                'Jeśli chcesz się wypisać, znajdź swoje imię na liście.\n'
                                'Przytrzymaj dłużej pole z twoim imieniem i wprowadź hasło.');
                      },
                      child: Text(
                        'Wypisz się',
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
