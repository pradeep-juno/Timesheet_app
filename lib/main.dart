import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:timesheet_proj/pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase for both Web and Mobile platforms
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBqBaooiinYkcz7KPob_QgWbAJwPr9zonA",
          authDomain: "timesheet-project-f451d.firebaseapp.com",
          projectId: "timesheet-project-f451d",
          storageBucket: "timesheet-project-f451d.appspot.com",
          messagingSenderId: "230302420353",
          appId: "1:230302420353:web:97a0318e60926cd157ec80",
          measurementId: "G-9FQL6G1WZK"),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: LoginPage(),
    );
  }
}
