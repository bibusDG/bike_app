// ignore_for_file: prefer_const_constructors
import 'package:bike_app/controllers/all_events_controller.dart';
import 'package:bike_app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AcctualEvents extends StatelessWidget {
  const AcctualEvents({super.key});

  @override
  Widget build(BuildContext context) {
    AllEventsController allEventsController = Get.find();

    Map _eventColor = {
      'Trening': Color.fromARGB(255, 253, 112, 102),
      'Zawody': Colors.lightBlue,
      'Relaks': Colors.tealAccent,
      'Las': Colors.green,
      'Szosa': Colors.grey
    };

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Aktualne wydarzenia'),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.info))],
        ),
        body: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Events')
                .orderBy('eventDate', descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('Loading');
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: ((context, index) {
                      var exactDate = snapshot.data!.docs[index]['eventDate']
                              .substring(0, 10) +
                          ' ' +
                          snapshot.data!.docs[index]['startEvent']
                              .substring(11, 23);
                      if (DateTime.parse(exactDate).isAfter(DateTime.now())) {
                        return GestureDetector(
                          onTap: () async {
                            allEventsController.eventID.value =
                                snapshot.data!.docs[index].reference.id;
                            await FirebaseServices().getSingleEvent(
                                allEventsController.eventID.value);
                            Get.toNamed('/eventDetails');
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 7.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                              color: _eventColor[snapshot.data!.docs[index]
                                  ['eventType']],
                              child: ListTile(
                                subtitle: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Data wydarzenia: ',
                                          style: TextStyle(fontSize: 17.0),
                                        ),
                                        Text(
                                          snapshot
                                              .data!.docs[index]['eventDate']
                                              .substring(0, 10),
                                          style: TextStyle(
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Godzina rozpoczęcia: ',
                                          style: TextStyle(fontSize: 20.0),
                                        ),
                                        Text(
                                          snapshot
                                              .data!.docs[index]['startEvent']
                                              .substring(11, 16),
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    // Row(
                                    //   children: [
                                    //     Text('Godzina zakończenia: '),
                                    //     Text(snapshot
                                    //         .data!.docs[index]['stopEvent']
                                    //         .substring(11, 16)),
                                    //   ],
                                    // ),
                                  ],
                                ),
                                title: Center(
                                  child: Text(
                                    snapshot.data!.docs[index]['eventName']
                                        .toUpperCase(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    }));
              }
            },
          ),
        ),
      ),
    );
  }
}
