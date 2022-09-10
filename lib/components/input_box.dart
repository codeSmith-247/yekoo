import 'package:flutter/material.dart';

// ignore: prefer_generic_function_type_aliases, camel_case_types
typedef dynamic callback(value);

class InputBox extends StatelessWidget {
  final callback usercallback;
  final String placeholder;
  final dynamic inputIcon;
  final dynamic inputType;
  final bool hidden;
  final double padx;
  final double pady;
  final double margy;
  final double margx;
  final controllerText;

  const InputBox(
      {super.key,
      required this.usercallback,
      this.placeholder = '',
      this.inputIcon = Icons.person,
      this.inputType = TextInputType.text,
      this.hidden = false,
      this.padx = 12.0,
      this.pady = 3.0,
      this.margx = 5.0,
      this.margy = 10.0,
      this.controllerText = ''});

  @override
  Widget build(BuildContext context) {
    if (hidden) {
      return _HiddenContainer(
        usercallback: usercallback,
        placeholder: placeholder,
        inputIcon: inputIcon,
        inputType: inputType,
      );
    }
    return InputContainer(
      margx: margx,
      margy: margy,
      pady: pady,
      padx: padx,
      child: InputElement(
        usercallback: usercallback,
        placeholder: placeholder,
        inputIcon: inputIcon,
        inputType: inputType,
        controllerText: controllerText,
      ),
    );
  }
}

class InputContainer extends StatelessWidget {
  final dynamic child;
  final dynamic color;
  final double padx;
  final double pady;
  final double margy;
  final double margx;

  const InputContainer(
      {super.key,
      this.child = '',
      this.color = const Color.fromARGB(51, 255, 255, 255),
      this.padx = 12.0,
      this.pady = 3.0,
      this.margx = 5.0,
      this.margy = 10.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: padx, vertical: pady),
      margin: EdgeInsets.symmetric(horizontal: margx, vertical: margy),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 2,
              color: Color.fromARGB(2, 0, 0, 0),
              offset: Offset(0, 0),
            ),
          ]),
      child: child,
    );
  }
}

class InputElement extends StatelessWidget {
  dynamic controller;
  final callback usercallback;
  final String placeholder;
  final dynamic inputIcon;
  final dynamic color;
  final dynamic inputType;
  final dynamic controllerText;

  InputElement(
      {super.key,
      required this.usercallback,
      this.placeholder = '',
      this.inputIcon = Icons.person,
      this.color = const Color.fromARGB(255, 158, 189, 255),
      this.inputType = TextInputType.text,
      this.controllerText = ''}) {
    controller = TextEditingController(text: controllerText);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        onChanged: (value) {
          usercallback(value);
        },
        textInputAction: TextInputAction.next,
        style: const TextStyle(fontSize: 18, color: Colors.white),
        keyboardType: inputType,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
              fontSize: 18, color: Color.fromARGB(92, 255, 255, 255)),
          hintText: placeholder,
          icon: Icon(inputIcon, color: color),
          border: InputBorder.none,
        ));
  }
}

class _HiddenContainer extends StatefulWidget {
  final dynamic color;
  final callback usercallback;
  final String placeholder;
  final dynamic inputIcon;
  final dynamic color2;
  final dynamic inputType;
  final double padx;
  final double pady;
  final double margy;
  final double margx;

  _HiddenContainer(
      {super.key,
      required this.usercallback,
      this.placeholder = '',
      this.inputIcon = Icons.person,
      this.color = const Color.fromARGB(255, 158, 189, 255),
      this.inputType = TextInputType.text,
      this.color2 = const Color.fromARGB(67, 255, 255, 255),
      this.padx = 12.0,
      this.pady = 3.0,
      this.margx = 5.0,
      this.margy = 10.0});

  final dynamic controller = TextEditingController();

  @override
  HiddenContainer createState() => HiddenContainer();
}

class HiddenContainer extends State<_HiddenContainer> {
  bool seeState = true;
  seePassword() {
    setState(() {
      seeState = !seeState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(
            horizontal: widget.padx, vertical: widget.pady),
        margin: EdgeInsets.symmetric(
            horizontal: widget.margx, vertical: widget.margy),
        decoration: BoxDecoration(
            color: widget.color2,
            borderRadius: BorderRadius.circular(25),
            boxShadow: const [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: 2,
                color: Color.fromARGB(2, 0, 0, 0),
                offset: Offset(0, 0),
              ),
            ]),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .6,

            // color: Colors.white,
            child: TextField(
                controller: widget.controller,
                onChanged: (value) {
                  widget.usercallback(value);
                },
                textInputAction: TextInputAction.next,
                style: const TextStyle(fontSize: 18, color: Colors.white),
                keyboardType: widget.inputType,
                obscureText: seeState,
                decoration: InputDecoration(
                  hintStyle: const TextStyle(
                      fontSize: 18, color: Color.fromARGB(92, 255, 255, 255)),
                  hintText: widget.placeholder,
                  icon: Icon(widget.inputIcon, color: widget.color),
                  border: InputBorder.none,
                )),
          ),
          IconButton(
            onPressed: () {
              seePassword();
            },
            icon: seeState
                ? const Icon(Icons.visibility_rounded,
                    color: Color.fromARGB(186, 255, 255, 255))
                : const Icon(
                    Icons.visibility_off_rounded,
                    color: Color.fromARGB(192, 255, 255, 255),
                  ),
          )
        ]));
  }
}
