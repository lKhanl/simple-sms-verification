import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobil_hw2/custom_app_bar.dart';
import 'package:mobil_hw2/home_screen.dart';

class SmsValidationScreen extends StatefulWidget {
  String number;
  SmsValidationScreen({Key? key, required this.number}) : super(key: key);

  @override
  State<SmsValidationScreen> createState() => _SmsValidationScreenState();
}

class _SmsValidationScreenState extends State<SmsValidationScreen> {
  final _numberController = TextEditingController();
  var numberLength = 0;
  int seconds = 20;
  Timer? timer;
  bool isRemaining = true;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), _onTick);
  }

  void _onTick(Timer timer) {
    setState(() {
      seconds--;
    });

    if (seconds == 0) {
      timer.cancel();
      isRemaining = false;
    }
  }

  void _inputHandler(String value) {
    if (value.length < 7) {
      setState(() {
        numberLength = value.length;
      });
    } else {
      _numberController.text = value.substring(0, 6);
      _numberController.selection = TextSelection.fromPosition(
        TextPosition(offset: _numberController.text.length),
      );
    }
  }

  void _continue() {
    if (numberLength == 6) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(name: "user")),
      );
    }
  }

  void _restartTimer() {
    seconds = 20;
    timer = Timer.periodic(const Duration(seconds: 1), _onTick);
    setState(() {
      isRemaining = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                  'Please enter the verification code sentto your mobile phone number with ${widget.number}'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.timer_outlined,
                  color: isRemaining ? Colors.black : Colors.red,
                ),
                const SizedBox(width: 4),
                Text('$seconds',
                    style: TextStyle(
                        color: isRemaining ? Colors.black : Colors.red)),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                controller: _numberController,
                maxLength: 6,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: numberLength == 6 ? Colors.green : Colors.red),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  labelText: 'SMS Code',
                  labelStyle: TextStyle(
                      color: numberLength == 6 ? Colors.green : Colors.red),
                  contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onChanged: _inputHandler,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: const BorderSide(color: Colors.black),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all((Colors.black)),
              ),
              onPressed: isRemaining ? _continue : _restartTimer,
              child:
                  isRemaining ? const Text('Continue') : const Text('Resend'),
            )
          ],
        ),
      ),
    );
  }
}
