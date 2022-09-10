import 'package:flutter/material.dart';
import 'package:yeekoo/components/bottom_navigation.dart';
import 'package:yeekoo/version_2/makepayment.dart';

dynamic outername;
dynamic outeremail;
dynamic outernumber;
dynamic outertripid;
dynamic outerstation;
dynamic outerprice;

dynamic loader = false;
dynamic seatTime = {'8:30pm': 10, '9:30pm': 20, '10:30pm': 8};
dynamic selection = {};
List<String> timeList = [];
List<DropdownMenuItem<Object>> dropdownItems = <DropdownMenuItem<Object>>[];
dynamic seatList = [];
dynamic selectedTime;
dynamic selectedSeat;

TextEditingController location = TextEditingController();
dynamic searchlocation;
// dynamic count

class Details extends StatefulWidget {
  final dynamic list;
  final dynamic tripid;
  final dynamic name;
  final dynamic email;
  final dynamic number;
  final dynamic price;
  final dynamic station;
  Details(
      {Key? key,
      this.list,
      this.tripid,
      this.name,
      this.station,
      this.email,
      this.number,
      this.price})
      : super(key: key) {
    outername = name;
    outeremail = email;
    outernumber = number;
    outertripid = tripid;
    outerstation = station;
    outerprice = price;

    selection = {};
    timeList = [];
    dropdownItems = [];
    seatList = [];
    seatTime = list;
    timeList = seatTime.keys.toList();

    for (int i = 0; i < timeList.length; i++) {
      dropdownItems.add(DropdownMenuItem(
        value: timeList[i],
        child: Text(timeList[i]),
      ));

      List<DropdownMenuItem<String>> sublist = [];

      for (int j = 1; j <= seatTime[timeList[i]]; j++) {
        sublist.add(DropdownMenuItem(value: "$j", child: Text("$j")));
      }

      seatList.add(sublist);

      String index = timeList[i];

      selection[index] = sublist;
    }

    selectedTime = timeList[0];
    selectedSeat = "1";
  }
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  restate() async {
    // outerlist = await getStations(widget.tripid, 0, search);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Booking Details"),
          backgroundColor: Color.fromARGB(255, 85, 82, 252)),
      bottomNavigationBar: BottomAppBar(
          color: Color.fromARGB(255, 85, 82, 252),
          child: BottomNavigation(
            fullname: "$outername",
            number: "$outernumber",
            email: "$outeremail",
          )),
      body: Stack(children: [
        DetailsBody(restate: restate),
        if (loader)
          const Opacity(
              opacity: 0.8,
              child: ModalBarrier(dismissible: false, color: Colors.black)),
        if (loader) const Center(child: CircularProgressIndicator())
      ]),
    );
  }
}

class DetailsBody extends StatelessWidget {
  final dynamic restate;
  const DetailsBody({Key? key, this.restate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            children: [
          Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 5,
                        color: Color.fromARGB(14, 129, 129, 129))
                  ]),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: const [
                      Padding(
                          padding: EdgeInsets.all(15),
                          child: Icon(Icons.timer)),
                      Text("Depature Time")
                    ]),
                    DropdownButton(
                        value: selectedTime,
                        items: dropdownItems,
                        onChanged: (value) {
                          selectedTime = value;
                          selectedSeat = "1";
                          restate();
                        })
                  ])),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 5,
                        color: Color.fromARGB(14, 129, 129, 129))
                  ]),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: const [
                      Padding(
                          padding: EdgeInsets.all(15),
                          child: Icon(Icons.airline_seat_recline_normal)),
                      Text("Number of Seats")
                    ]),
                    DropdownButton(
                        value: selectedSeat,
                        items: selection[selectedTime],
                        onChanged: (value) {
                          selectedSeat = value;
                          restate();
                        })
                  ])),
          GestureDetector(
            onTap: () async {
              loader = true;
              restate();
              // outerlist = await getTrips(searchlocation, searchdestination, stop);
              loader = false;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Makepayment(
                            station: outerstation,
                            name: outername,
                            number: outernumber,
                            email: outeremail,
                            tripid: outertripid,
                            amount: outerprice,
                            seats: selectedSeat,
                            time: selectedTime,
                          )));
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
                prefixIcon: Icon(Icons.phone, color: iconColor),
                // suffixIcon: const Icon(Icons.directions_bus_filled_outlined,
                //     color: Color.fromARGB(54, 26, 71, 113)),
                border: InputBorder.none)));
  }
}
