import 'package:flutter/material.dart';
import '../components/image_component.dart';
import '../components/input_box.dart';
import '../components/button.dart';
import '../components/bottom_text.dart';
import 'package:flash/flash.dart';
import '../functions/login.dart';

dynamic number = '';
dynamic password = '';

class LoginPage extends StatefulWidget {
   LoginPage({super.key}) {
    number = '';
    password = '';
  }

  @override
  // ignore: library_private_types_in_public_api
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  bool loader = false;

  int attempt() {
    return 0;
  }

  void statefunction() async {
    setState(() {
      loader = true;
    });

    await login(number, password, context.showFlashDialog, context);

    setState(() {
      loader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 24, 39, 181),
        body: Stack(children: [
          LoginBody(
            statefunction: () {
              statefunction();
            },
          ),
          if (loader)
            const Opacity(
                opacity: 0.8,
                child: ModalBarrier(dismissible: false, color: Colors.black)),
          if (loader) const Center(child: CircularProgressIndicator())
        ]));
  }
}

class LoginBody extends StatelessWidget {
  final dynamic statefunction;
  const LoginBody({super.key, this.statefunction});

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //         begin: Alignment.topCenter,
        //         end: Alignment.bottomCenter,
        //         colors: [Color.fromARGB(255, 85, 82, 252), Color.fromARGB(255, 19, 111, 186)])),
        child: Center(
          child: LoginContent(statefunction: statefunction),
        ));
  }
}



InputBox numberInput = InputBox(
    usercallback: (value) {
      // print(value);
      number = value;
    },
    placeholder: "Telephone Number",
    inputIcon: Icons.phone_android,
    inputType: TextInputType.phone);

InputBox passwordInput = InputBox(
    usercallback: (value) {
      // print(value);
      password = value;
    },
    placeholder: "Password",
    inputType: TextInputType.text,
    inputIcon: Icons.lock,
    hidden: true);

class LoginContent extends StatelessWidget {
  final dynamic statefunction;
  const LoginContent({super.key, this.statefunction});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: CustomScroll(),
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            const ImageBox(
              link: "assets/yekoo.jpg",
              height: 30,
            ),
            numberInput,
            passwordInput,
            Button(
                statefunction: () {
                  // print("clicked me");
                  statefunction();
                },
                text: "Procceed"),
            const BottomText(
                callback: false,
                firstText: "Dont Have An Account? ",
                secondText: "Sign Up")
          ],
        ));
  }
}

//custom scroll to remove blue scroll glow
class CustomScroll extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
