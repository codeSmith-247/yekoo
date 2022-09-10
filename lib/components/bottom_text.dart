import 'package:flutter/material.dart';
import 'package:yeekoo/version_2/login.dart';
import 'package:yeekoo/version_2/signup.dart';

class BottomText extends StatelessWidget {
  final dynamic firstText;
  final dynamic secondText;
  final bool callback;
  const BottomText(
      {super.key,
      required this.firstText,
      required this.secondText,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Center(
            child: Wrap(children: [
          Text(firstText, style: const TextStyle(color: Colors.white)),
          GestureDetector(
              onTap: () {
                if (callback)
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage()));
                if (!callback)
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupPage()));
              },
              child: Text(secondText,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 125, 147, 255),
                    decoration: TextDecoration.underline,
                  ))),
        ])));
  }
}
