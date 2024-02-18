import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'StaticPage2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

      // options: DefaultFirebaseOptions.currentPlatform,
      options: const FirebaseOptions(
          apiKey: "AIzaSyDXOVcE8-POU-1D1bCr1AjtFdD1HUJEP84",
          appId: "1:472305237336:android:57b049f20d3bafc6d9792d",
          messagingSenderId: "472305237336",
          projectId: "health360-5ba1a"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Static2());
  }
}
