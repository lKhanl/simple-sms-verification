import 'package:flutter/material.dart';
import 'package:mobil_hw2/phone_number_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Programming Homework 2',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const PhoneNumberScreen(),
    );
  }
}
