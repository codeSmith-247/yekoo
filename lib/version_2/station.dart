import 'package:flutter/material.dart';
import 'package:yeekoo/components/bottom_navigation.dart';
import 'package:yeekoo/functions/stations.dart';
import 'package:yeekoo/functions/details.dart';
import 'package:yeekoo/version_2/details.dart';

dynamic loader = false;
dynamic search;

dynamic outerlist;
dynamic stop;

dynamic outername;
dynamic outeremail;
dynamic outernumber;
dynamic outertripid;
dynamic station;

class Station extends StatefulWidget {
  final dynamic tripid;
  final dynamic name;
  final dynamic email;
  final dynamic number;
  final dynamic list;
  Station(
      {super.key, this.name, this.email, this.number, this.list, this.tripid}) {
    // print("restart works here");
    outerlist = list;
    outername = name;
    outeremail = email;
    outernumber = number;
    outertripid = tripid;
    station = name;
    stop = list.length > 0 ? list[list.length - 1]['id'] : 0;
  }

  @override
  _StationState createState() => _StationState();
}

class _StationState extends State<Station> {
  restate() async {
    outerlist = await getStations(widget.tripid, 0, search);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Select Station"),
          backgroundColor: const Color.fromARGB(255, 85, 82, 252)),
      bottomNavigationBar: BottomAppBar(
          color: const Color.fromARGB(255, 85, 82, 252),
          child: BottomNavigation(
            fullname: "$outername",
            number: "$outernumber",
            email: "$outeremail",
          )),
      body: Stack(children: [
        StationBody(restate: restate),
        if (loader)
          const Opacity(
              opacity: 0.8,
              child: ModalBarrier(dismissible: false, color: Colors.black)),
        if (loader) const Center(child: CircularProgressIndicator())
      ]),
    );
  }
}

class StationBody extends StatelessWidget {
  final dynamic restate;
  const StationBody({Key? key, this.restate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Search(restate: restate),
        for (int i = 0; i < outerlist.length; i++)
          Tab(
              location: outerlist[i]['station'],
              destination: outerlist[i]['price'],
              locationLen: outerlist[i]['station'].length > 12
                  ? 12
                  : outerlist[i]['station'].length,
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
            const Text("No Stations Available",
                style: TextStyle(fontSize: 20, fontFamily: 'sans-serif')),
          ]),
      ],
    );
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
              child: const Text("Search Station",
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
                        hint: "Search for a station...",
                        iconColor: const Color.fromARGB(167, 0, 143, 215),
                        controller: stationsearch,
                        callback: (value) {
                          search = value;
                          restate();
                        }),
                  ],
                )
              ],
            )
          ],
        ));
  }
}

TextEditingController stationsearch = TextEditingController();

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
                suffixIcon: const Icon(Icons.directions_bus_filled_outlined,
                    color: Color.fromARGB(54, 26, 71, 113)),
                border: InputBorder.none)));
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
        dynamic stationlist = await getDetails(outertripid);
        Map modifiedlist = <String, int>{};

        for (int i = 0; i < stationlist.length; i++) {
          modifiedlist[stationlist[i]['time']] = stationlist[i]['seat'];
        }
        
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Details(
                    list: modifiedlist,
                    price: destination,
                    name: outername,
                    station: location,
                    tripid: outertripid,
                    email: outeremail,
                    number: outernumber)));
      },
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
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
                    width: MediaQuery.of(context).size.width * .2,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            bottomLeft: Radius.circular(35)),
                        image: DecorationImage(
                            image: AssetImage('assets/station.jpg'),
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
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
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
                      Text("Ghc $destination",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 96, 96, 96),
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
              child: const Icon(Icons.luggage,
                  color: Color.fromARGB(255, 255, 255, 255), size: 25),
            )
          ])),
    );
  }
}
