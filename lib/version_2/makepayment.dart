// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yeekoo/components/bottom_navigation.dart';
import 'package:yeekoo/version_2/home.dart';
import 'package:yeekoo/version_2/ticket.dart';
import 'package:yeekoo/functions/maketicket.dart';
// import 'package:flutter_paystack/flutter_paystack.dart';

// class MakePayment {
//   BuildContext ctx;
//   int price;
//   String email;

//   MakePayment({required this.ctx, required this.price, required this.email});

//   // @overrideimport 'dart:async';
// import 'package:webview_flutter/webview_flutter.dart';
//   // Widget build(BuildContext context) {
//   //   return Container();
//   // }
//   PaystackPlugin plugin = PaystackPlugin();

// }

dynamic fullname;
dynamic outeremail;
dynamic outernumber;
dynamic outerstation;
dynamic outertripid;
dynamic outeramount;
dynamic outerseats;
dynamic outertime;

class Makepayment extends StatefulWidget {
  final dynamic name;
  final dynamic number;
  final dynamic email;
  final dynamic tripid;
  final dynamic station;
  final dynamic amount;
  final dynamic seats;
  final dynamic time;
  Makepayment(
      {super.key,
      this.name,
      this.number,
      this.email,
      this.tripid,
      this.amount,
      this.station,
      this.seats,
      this.time}) {
    fullname = name;
    outernumber = number;
    outeremail = email;
    outerstation = station;
    outeramount = amount;
    outertripid = tripid;
    outerseats = seats;
    outertime = time;
  }

  @override
  _MakepaymentState createState() => _MakepaymentState();
}

class _MakepaymentState extends State<Makepayment> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text(message.message)));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Make Payment"),
          backgroundColor: const Color.fromARGB(255, 85, 82, 252)),
      bottomNavigationBar: BottomAppBar(
          color: const Color.fromARGB(255, 85, 82, 252),
          child: BottomNavigation(
            fullname: "$outername",
            number: "$outernumber",
            email: "$outeremail",
          )),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Builder(builder: (BuildContext context) {
          return WebView(
            initialUrl:
                "https://opiononline.com/server_code/makepayment.php?email=adedavid.tech@gmail.com&amount=200",
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            onProgress: (int progress) {
              print("Progress $progress");
            },
            javascriptChannels: <JavascriptChannel>{
              JavascriptChannel(
                  name: 'MessageInvoker',
                  onMessageReceived: (s) async {
                    if (s.message != "Payment Unsuccessfull") {
                      // print(outerstation);
                      // print(outeramount);
                      // print(s.message);
                      // print(outertripid);
                      // print(outernumber);
                      // print(outerseats);
                      // print("here");
                      await maketicket(
                          outername,
                          outeremail,
                          outerstation,
                          outeramount,
                          s.message,
                          outertripid,
                          outernumber,
                          outerseats,
                          outertime,
                          context);
                      // print(s);
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(s.message),
                      ));
                    } else {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home(
                                    name: '$fullname',
                                    number: '$outernumber',
                                    email: '$outeremail',
                                    list: bottomouterlocationList,
                                  )),
                          (route) => false);
                    }
                  }),
            },
            onPageFinished: (value) {
              
            },
          );
        }),
      ),
    );
  }
}
