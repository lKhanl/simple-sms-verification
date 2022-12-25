import 'package:flutter/material.dart';
import 'package:mobil_hw2/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  String type = "Guest!";
  var name;

  HomeScreen({Key? key, this.name}) : super(key: key) {
    if (name == "user") {
      type = "Özgür Özşen!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: Text(
          "Welcome $type",
          style: const TextStyle(fontSize: 36, color: Colors.grey),
        ),
      ),
    );
  }
}
