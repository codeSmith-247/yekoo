// ignore_for_file: unused_element

import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final dynamic text;
  final dynamic statefunction;
  final double padding;
  const Button({super.key, this.text, this.statefunction, this.padding = 15.0});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
        child: ElevatedButton(
          onPressed: () {
            statefunction();
          },
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(const Color.fromARGB(255, 109, 106, 255)),
            foregroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 255, 255, 255)),
            padding: MaterialStateProperty.all(EdgeInsets.all(padding)),
            textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
            elevation: MaterialStateProperty.all(6.0),
          ),
          child: Text(text),
        ));
  }
}
