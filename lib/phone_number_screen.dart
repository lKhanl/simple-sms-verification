import 'package:flutter/material.dart';
import 'package:mobil_hw2/custom_app_bar.dart';
import 'package:mobil_hw2/home_screen.dart';
import 'package:mobil_hw2/sms_validation_screen.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final _numberController = TextEditingController();
  final _key = GlobalKey<FormState>();
  int numberLength = 0;
  late String number;
  void _login() {
    setState(() {
      number = _numberController.text;
    });

    if (numberLength == 13) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SmsValidationScreen(number: number)),
      );
    }
  }

  void _inputHandler(String value) {
    if (value.length < 14) {
      if (value.length == 4 || value.length == 8) {
        _numberController.text = "$value ";
        _numberController.selection = TextSelection.fromPosition(
          TextPosition(offset: _numberController.text.length),
        );
      }

      setState(() {
        numberLength = value.length;
      });
    } else {
      _numberController.text = value.substring(0, 13);
      _numberController.selection = TextSelection.fromPosition(
        TextPosition(offset: _numberController.text.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  style: const TextStyle(fontSize: 20),
                  controller: _numberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  onChanged: _inputHandler,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all((Colors.black)),
                  ),
                  onPressed: _login,
                  child: SizedBox(
                    height: 33,
                    width: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Login"),
                        SizedBox(width: 5),
                        Icon(Icons.arrow_forward),
                      ],
                    ),
                  )),
              const SizedBox(height: 30),
              Row(children: const <Widget>[
                SizedBox(width: 40),
                Expanded(child: Divider()),
                SizedBox(width: 20),
                Text("OR"),
                SizedBox(width: 20),
                Expanded(child: Divider()),
                SizedBox(width: 40),
              ]),
              const SizedBox(height: 60),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(
                                name: "null",
                              )),
                    );
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(color: Colors.black),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all((Colors.white)),
                  ),
                  child: const Text(
                    "Continue without login",
                    style: TextStyle(color: Colors.grey),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
