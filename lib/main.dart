import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_formation/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase App
  Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBd2x9HzBl4muZ2gd0EZwA0ZXse53oO2ZY",
        authDomain: "rpi-image-b98b8.firebaseapp.com",
        databaseURL: "https://rpi-image-b98b8-default-rtdb.firebaseio.com",
        projectId: "rpi-image-b98b8",
        storageBucket: "rpi-image-b98b8.appspot.com",
        messagingSenderId: "412613716500",
        appId: "1:412613716500:web:44557c0c7e202541035501",
        measurementId: "G-KWHSDFYQBR"),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginScreen(),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'live.dart'; // Import your LiveCam widget

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBd2x9HzBl4muZ2gd0EZwA0ZXse53oO2ZY",
        authDomain: "rpi-image-b98b8.firebaseapp.com",
        databaseURL: "https://rpi-image-b98b8-default-rtdb.firebaseio.com",
        projectId: "rpi-image-b98b8",
        storageBucket: "rpi-image-b98b8.appspot.com",
        messagingSenderId: "412613716500",
        appId: "1:412613716500:web:44557c0c7e202541035501",
        measurementId: "G-KWHSDFYQBR"),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My App',
      home: LiveCam(),
    );
  }
}*/
