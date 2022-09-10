import 'package:flutter/material.dart';
import 'package:yeekoo/version_2/login.dart';
// import '../components/image_component.dart';
import '../components/input_box.dart';
import '../components/button.dart';
import '../components/bottom_text.dart';
import 'package:flash/flash.dart';
import '../functions/signup.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupPage createState() => _SignupPage();
}

class _SignupPage extends State<SignupPage> {
  bool loader = false;

  int attempt() {
    return 0;
  }

  void statefunction() async {
    setState(() {
      loader = true;
    });

    await signup(fullname, number, email, password, repeatpassword,
        context.showFlashDialog, context);

    setState(() {
      loader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 24, 39, 181),
        body: Stack(children: [
          SignupBody(
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

class SignupBody extends StatelessWidget {
  final dynamic statefunction;
  const SignupBody({super.key, this.statefunction});

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      // color: Colors.red,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      // decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //         begin: Alignment.topCenter,
      //         end: Alignment.bottomCenter,
      //         colors: [Color.fromARGB(255, 85, 82, 252), Color.fromARGB(255, 19, 111, 186)])),
      child: SignupContent(statefunction: statefunction),
    );
  }
}

dynamic fullname = '';
dynamic number = '';
dynamic email = '';
dynamic password = '';
dynamic repeatpassword = '';

InputBox nameInput = InputBox(
    usercallback: (value) {
      // print(value);
      fullname = value;
    },
    margy: 10,
    placeholder: "Full Name",
    inputIcon: Icons.person,
    inputType: TextInputType.text);

InputBox numberInput = InputBox(
    usercallback: (value) {
      // print(value);
      number = value;
    },
    margy: 10,
    placeholder: "Telephone Number",
    inputIcon: Icons.phone_android,
    inputType: TextInputType.phone);

InputBox emailInput = InputBox(
  usercallback: (value) {
    // print(value);
    email = value;
  },
  margy: 10,
  placeholder: "Email",
  inputIcon: Icons.mail,
);

InputBox passwordInput = InputBox(
    usercallback: (value) {
      // print(value);
      password = value;
    },
    margy: 10,
    placeholder: "Password",
    inputIcon: Icons.lock,
    hidden: true);

InputBox repeatpasswordInput = InputBox(
    usercallback: (value) {
      // print(value);
      repeatpassword = value;
    },
    margy: 10,
    placeholder: "Repeat Password",
    inputIcon: Icons.lock,
    hidden: true);

int count = 0;

gotologin(context) {
  if (count > 0) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
  count++;
}

class SignupContent extends StatelessWidget {
  final dynamic statefunction;
  const SignupContent({super.key, this.statefunction});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: CustomScroll(),
        child: Center(
            child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          children: <Widget>[
            Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: const Text("Sign Up",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold))),
            nameInput,
            numberInput,
            emailInput,
            passwordInput,
            repeatpasswordInput,
            Button(
                statefunction: () {
                  // print("clicked me");
                  statefunction();
                },
                text: "Procceed"),
            const BottomText(
                callback: true,
                firstText: "Already Have An Account? ",
                secondText: "Log In")
          ],
        )));
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
