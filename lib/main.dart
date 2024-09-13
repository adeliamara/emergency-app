import 'package:emergency_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';

import 'core/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Location.instance.requestPermission();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xFFFF3B30), primary: Color(0xFFFF3B30)),
        useMaterial3: true,
      ),
    );
  }
}
