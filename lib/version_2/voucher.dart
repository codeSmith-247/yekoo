import 'package:flutter/material.dart';
import 'package:yeekoo/components/bottom_navigation.dart';
// import 'package:yeekoo/version_2/makepayment.dart';
import 'package:flash/flash.dart';
import 'package:yeekoo/functions/voucher.dart';

dynamic outername;
dynamic outeremail;
dynamic outernumber;

dynamic loader = false;

TextEditingController location = TextEditingController();
dynamic searchlocation;
// dynamic count

class Voucher extends StatefulWidget {
  final dynamic name;
  final dynamic email;
  final dynamic number;
  Voucher({Key? key, this.name, this.email, this.number}) : super(key: key) {
    outername = name;
    outeremail = email;
    outernumber = number;
  }
  @override
  _VoucherState createState() => _VoucherState();
}

class _VoucherState extends State<Voucher> {
  restate() async {
    // outerlist = await getStations(widget.tripid, 0, search);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Booking Voucher"),
          backgroundColor: const Color.fromARGB(255, 85, 82, 252)),
      bottomNavigationBar: BottomAppBar(
          color: const Color.fromARGB(255, 85, 82, 252),
          child: BottomNavigation(
            fullname: "$outername",
            number: "$outernumber",
            email: "$outeremail",
          )),
      body: Stack(children: [
        VoucherBody(restate: restate),
        if (loader)
          const Opacity(
              opacity: 0.8,
              child: ModalBarrier(dismissible: false, color: Colors.black)),
        if (loader) const Center(child: CircularProgressIndicator())
      ]),
    );
  }
}

TextEditingController mycontroller = TextEditingController();

class VoucherBody extends StatelessWidget {
  final dynamic restate;
  dynamic bookingcode;
  VoucherBody({Key? key, this.restate}) : super(key: key);

  callback(value) {
    bookingcode = value;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            children: [
          Input(
            controller: mycontroller,
            hint: "Provide your booking code...",
            callback: callback,
          ),
          GestureDetector(
            onTap: () async {
              loader = true;
              restate();
              dynamic result = await fetchvoucher(
                  outername, outeremail, outernumber, bookingcode, context);
              if (!result) {
                showErrorMessage(
                    "Invalid Voucher",
                    "Invalid Voucher code, please check voucher code and try again",
                    'Try Again',
                    context.showFlashDialog,
                    context);
              }
              loader = false;
              restate();
            },
            child: Container(
                width: MediaQuery.of(context).size.width * .85,
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 85, 82, 252),
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5,
                          spreadRadius: 5,
                          color: Color.fromARGB(28, 115, 25, 183))
                    ]),
                child: const Center(
                    child: Text("Book Now",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold)))),
          ),
        ]));
  }
}

class Input extends StatelessWidget {
  final dynamic iconColor;
  final dynamic hint;
  final dynamic controller;
  final dynamic callback;
  const Input(
      {Key? key, this.iconColor, this.hint, this.controller, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * .8,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color.fromARGB(15, 71, 71, 71),
            ),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 5,
                  color: Color.fromARGB(14, 129, 129, 129))
            ],
            borderRadius: const BorderRadius.all(Radius.circular(35))),
        child: TextField(
            onChanged: (value) {
              callback(value);
            },
            controller: controller,
            decoration: InputDecoration(
                hintText: hint,
                contentPadding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                prefixIcon: Icon(Icons.local_offer_outlined, color: iconColor),
                // suffixIcon: const Icon(Icons.directions_bus_filled_outlined,
                //     color: Color.fromARGB(54, 26, 71, 113)),
                border: InputBorder.none)));
  }
}

void showErrorMessage(title, message, btnText, contextDialog, context) {
  contextDialog(
    title: Text(title),
    content: Center(child: Text(message)),
    negativeActionBuilder: (context, controller, _) {
      return TextButton(
        onPressed: () {
          controller.dismiss();
        },
        child: Text(btnText),
      );
    },
  );
}
