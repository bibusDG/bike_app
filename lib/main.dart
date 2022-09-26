// ignore_for_file: prefer_const_constructors

import 'package:bike_app/pages/acctual_events/acctual_events.dart';
import 'package:bike_app/pages/event_details/event_details.dart';
import 'package:bike_app/pages/home_page/home_page.dart';
import 'package:bike_app/pages/new_event/new_event.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bike_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Firebase initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      getPages: [
        GetPage(name: '/newEvent', page: () => NewEvent()),
        GetPage(name: '/acctualEvents', page: () => AcctualEvents()),
        GetPage(
          name: '/eventDetails',
          page: () => EventDetails(),
        )
      ],
    );
  }
}
