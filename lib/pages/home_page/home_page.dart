// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:bike_app/controllers/all_events_controller.dart';
import 'package:bike_app/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    AllEventsController allEventsController = Get.put(AllEventsController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Rowerowy Kwidzyn'),
        ),
        body: Center(
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              MainPageButton(
                pageName: '/newEvent',
                buttonText: 'Utwórz nowe wydarzenie',
              ),
              MainPageButton(
                pageName: '/acctualEvents',
                buttonText: 'Aktualne wydarzenia',
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MainPageButton extends StatelessWidget {
  String pageName;
  String buttonText;
  MainPageButton({
    required this.buttonText,
    required this.pageName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 150,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0))),
          onPressed: () {
            Get.toNamed(pageName);
            if (buttonText == 'Aktualne wydarzenia') {
              FirebaseServices().fetchRecords();
            }
          },
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 25.0),
          ),
        ),
      ),
    );
  }
}
