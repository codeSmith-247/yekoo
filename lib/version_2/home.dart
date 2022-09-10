// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:yeekoo/components/bottom_navigation.dart';
import 'package:yeekoo/functions/trips.dart';
import 'package:yeekoo/version_2/station.dart';
import 'package:yeekoo/functions/stations.dart';
import 'package:flash/flash.dart';

dynamic outerlist;
dynamic outername;
dynamic outeremail;
dynamic outernumber;

dynamic searchlocation;
dynamic searchdestination;
dynamic stop = 0;
dynamic loader = false;

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

class Home extends StatefulWidget {
  final dynamic name;
  final dynamic email;
  final dynamic number;
  final dynamic list;
  Home({super.key, this.name, this.email, this.number, this.list}) {
    // print("restart works here");
    outerlist = list;
    outername = name;
    outeremail = email;
    outernumber = number;
    stop = list[list.length - 1]['id'];
  }

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  restate() async {
    outerlist = await getTrips(searchlocation, searchdestination, stop);
    stop = outerlist.length > 0 ? outerlist[outerlist.length - 1]['id'] : 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(outername),
          backgroundColor: const Color.fromARGB(255, 85, 82, 252)),
      bottomNavigationBar: BottomAppBar(
          color: const Color.fromARGB(255, 85, 82, 252),
          child: BottomNavigation(
              fullname: "$outername",
              number: "$outernumber",
              email: "$outeremail",
              locationList: widget.list)),
      body: Stack(children: [
        HomeBody(restate: restate),
        if (loader)
          const Opacity(
              opacity: 0.8,
              child: ModalBarrier(dismissible: false, color: Colors.black)),
        if (loader) const Center(child: CircularProgressIndicator())
      ]),
    );
  }
}

class HomeBody extends StatelessWidget {
  final dynamic restate;
  const HomeBody({Key? key, this.restate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Search(restate: restate),
        for (int i = 0; i < outerlist.length; i++)
          Tab(
              location: outerlist[i]['location'],
              destination: outerlist[i]['destination'],
              locationLen: outerlist[i]['location'].length > 12
                  ? 12
                  : outerlist[i]['location'].length,
              destinationLen: outerlist[i]['destination'].length > 12
                  ? 12
                  : outerlist[i]['destination'].length,
              tripid: outerlist[i]['id']
              // Tab(),
              ),
        if (outerlist.length == 0)
          Column(children: [
            Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: MediaQuery.of(context).size.height * .2,
                width: MediaQuery.of(context).size.height * .2,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(105)),
                    image: DecorationImage(
                        image: AssetImage('assets/bus.jpg'),
                        fit: BoxFit.cover))),
            const Text("Trip is currently unavailable",
                style: TextStyle(fontSize: 20, fontFamily: 'sans-serif')),
          ]),
        GestureDetector(
          onTap: () async {
            loader = true;
            restate();
            outerlist = await getTrips(searchlocation, searchdestination, stop);
            loader = false;
            restate();
          },
          child: Container(
              width: MediaQuery.of(context).size.width * .85,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 85, 82, 252),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 5,
                        color: Color.fromARGB(28, 115, 25, 183))
                  ]),
              child: const Center(
                  child: Text("Show More",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold)))),
        ),
      ],
    );
  }
}

TextEditingController location = TextEditingController();
TextEditingController destination = TextEditingController();

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
            border: Border.all(
              color: const Color.fromARGB(15, 71, 71, 71),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: TextField(
            onChanged: (value) {
              callback(value);
            },
            controller: controller,
            decoration: InputDecoration(
                hintText: hint,
                contentPadding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                prefixIcon: Icon(Icons.noise_control_off, color: iconColor),
                suffixIcon: const Icon(Icons.location_on_sharp,
                    color: Color.fromARGB(54, 26, 71, 113)),
                border: InputBorder.none)));
  }
}

class Search extends StatelessWidget {
  final dynamic restate;
  const Search({Key? key, this.restate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 10,
                  color: Color.fromARGB(14, 0, 0, 0))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 17),
              // decoration: BoxDecoration(
              //     border: Border.all(color: Colors.black, width: 2.0),
              //     borderRadius:
              //         const BorderRadius.all(Radius.circular(40))),
              child: const Text("Search Location",
                  style: TextStyle(
                      color: Color.fromARGB(255, 55, 55, 55),
                      // fontStyle: FontStyle.italic,
                      fontSize: 18,
                      fontWeight: FontWeight.w100,
                      letterSpacing: 0.8)),
            ),
            Row(
              children: [
                // const Padding(
                //     padding: EdgeInsets.all(10),
                //     child: Icon(Icons.search, size: 30)),
                Column(
                  children: [
                    Input(
                        hint: "Starting Location",
                        iconColor: const Color.fromARGB(167, 0, 143, 215),
                        controller: location,
                        callback: (value) {
                          searchlocation = value;
                          restate();
                        }),
                    Input(
                        hint: "Target Location",
                        iconColor: const Color.fromARGB(255, 0, 215, 7),
                        controller: destination,
                        callback: (value) {
                          searchdestination = value;
                          restate();
                        })
                  ],
                )
              ],
            )
          ],
        ));
  }
}

class Tab extends StatelessWidget {
  final dynamic location;
  final dynamic destination;
  final dynamic locationLen;
  final dynamic destinationLen;
  final dynamic tripid;
  const Tab(
      {Key? key,
      this.tripid,
      this.location,
      this.destination,
      this.locationLen,
      this.destinationLen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        dynamic stationlist = await getStations(tripid, 0, '');

        if (stationlist == false) {
          // ignore: use_build_context_synchronously
          showErrorMessage(
              'Stations Unavailable',
              "There are no stations available for this trip, please try again later",
              "close",
              context.showFlashDialog,
              context);
        } else {
          // ignore: use_build_context_synchronously
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Station(
                      list: stationlist,
                      tripid: tripid,
                      name: outername,
                      email: outeremail,
                      number: outernumber)));
        }
      },
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(35)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    spreadRadius: 5,
                    color: Color.fromARGB(14, 129, 129, 129))
              ]),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * .1,
                    width: MediaQuery.of(context).size.width * .22,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35),
                            bottomLeft: Radius.circular(35)),
                        image: DecorationImage(
                            image: AssetImage('assets/location.jpg'),
                            fit: BoxFit.cover))),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          child: Icon(
                            Icons.noise_control_off,
                            color: Color.fromARGB(167, 0, 143, 215),
                            size: 15,
                          )),
                      Text("$location".substring(0, locationLen),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 86, 86, 86),
                          ))
                    ]),
                    Row(children: [
                      const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          child: Icon(
                            Icons.noise_control_off,
                            color: Color.fromARGB(255, 147, 255, 145),
                            size: 15,
                          )),
                      Text("$destination".substring(0, destinationLen),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 36, 36, 36),
                          ))
                    ]),
                  ],
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              height: MediaQuery.of(context).size.height * .06,
              width: MediaQuery.of(context).size.height * .06,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: Color.fromARGB(255, 85, 82, 252),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 5,
                        color: Color.fromARGB(14, 129, 129, 129))
                  ]),
              child: const Icon(Icons.directions_bus_filled_outlined,
                  color: Color.fromARGB(255, 255, 255, 255), size: 25),
            )
          ])),
    );
  }
}

class Button extends StatelessWidget {
  const Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 85, 82, 252),
          borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }
}
