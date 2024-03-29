import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'src/home/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(hintColor: Colors.white70)));
}
