import 'package:yeekoo/components/bottom_navigation.dart';
import 'package:flutter/material.dart';

dynamic loader = false;
dynamic outerlist = [];
dynamic outernamee;
dynamic outeremail;
dynamic outernumber;

class Ticket extends StatefulWidget {
  final dynamic list;
  final dynamic name;
  final dynamic email;
  final dynamic number;
  Ticket({Key? key, this.list, this.name, this.email, this.number})
      : super(key: key) {
    outerlist = [];
    outerlist = list;
    outernamee = name;
    outeremail = email;
    outernumber = number;
  }

  @override
  _TicketState createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  restate() async {
    // outerlist = await getStations(widget.tripid, 0, search);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text("Tickets"),
          backgroundColor: const Color.fromARGB(255, 85, 82, 252)),
      bottomNavigationBar: BottomAppBar(
          color: const Color.fromARGB(255, 85, 82, 252),
          child: BottomNavigation(
            fullname: "$outernamee",
            number: "$outernumber",
            email: "$outeremail",
          )),
      body: Stack(children: [
        TicketBody(restate: restate),
        if (loader)
          const Opacity(
              opacity: 0.8,
              child: ModalBarrier(
                  dismissible: false,
                  color: Color.fromARGB(255, 246, 243, 255))),
        if (loader) const Center(child: CircularProgressIndicator())
      ]),
    );
  }
}

class TicketBody extends StatelessWidget {
  final dynamic restate;
  const TicketBody({Key? key, this.restate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(0), children: [
      for (int i = 0; i < outerlist.length; i++)
        TicketTab(
            station: outerlist[i]["station"],
            location: outerlist[i]["location"],
            destination: outerlist[i]["destination"],
            amount: outerlist[i]["amount"],
            seats: outerlist[i]["seats"],
            time: outerlist[i]["Dtime"],
            status: outerlist[i]["status"],
            bookingcode: outerlist[i]["voucher"]),
      if (outerlist.length == 0)
        Container(
          height: MediaQuery.of(context).size.height * .75,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Container(
                height: MediaQuery.of(context).size.height * .5,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/tickets.jpg'),
                        fit: BoxFit.contain))),
          ),
        )
    ]);
  }
}

class TicketTab extends StatelessWidget {
  final dynamic station;
  final dynamic location;
  final dynamic destination;
  final dynamic seats;
  final dynamic time;
  final dynamic amount;
  final dynamic status;
  final dynamic bookingcode;

  const TicketTab(
      {Key? key,
      this.station,
      this.location,
      this.destination,
      this.seats,
      this.time,
      this.amount,
      this.status,
      this.bookingcode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 1),
        padding: const EdgeInsets.symmetric(vertical: 15),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .62,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(0)),
          color: Color.fromARGB(255, 44, 0, 97),
        ),
        child: Column(children: [
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width * .85,
                height: MediaQuery.of(context).size.height * .4,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Column(children: [
                  Container(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20)),
                                color: const Color.fromARGB(255, 246, 243, 255),
                                border: Border.all(
                                    width: .5,
                                    color: const Color.fromARGB(28, 0, 0, 0)),
                              ),
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("station: ",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 27, 26, 26),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500)),
                                  Text("$station",
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 23, 23, 23),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500)),
                                ],
                              )),
                          Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 246, 243, 255),
                                border: Border.all(
                                    width: .5,
                                    color: const Color.fromARGB(28, 0, 0, 0)),
                              ),
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("From: ",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 23, 23, 23),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500)),
                                  Text("$location",
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 23, 23, 23),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500)),
                                ],
                              )),
                          Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 246, 243, 255),
                                border: Border.all(
                                    width: .5,
                                    color: const Color.fromARGB(28, 0, 0, 0)),
                              ),
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("To: ",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 23, 23, 23),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500)),
                                  Text("$destination",
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 23, 23, 23),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500)),
                                ],
                              )),
                          Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 246, 243, 255),
                                border: Border.all(
                                    width: .5,
                                    color: const Color.fromARGB(28, 0, 0, 0)),
                              ),
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Seats: ",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 23, 23, 23),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500)),
                                  Text("$seats",
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 23, 23, 23),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500)),
                                ],
                              )),
                          Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 246, 243, 255),
                                border: Border.all(
                                    width: .5,
                                    color: const Color.fromARGB(28, 0, 0, 0)),
                              ),
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Time: ",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 23, 23, 23),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500)),
                                  Text("$time",
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 23, 23, 23),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500)),
                                ],
                              )),
                          Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 246, 243, 255),
                                border: Border.all(
                                    width: .5,
                                    color: const Color.fromARGB(28, 0, 0, 0)),
                              ),
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Amount: ",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 23, 23, 23),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500)),
                                  Text("Ghc $amount",
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 23, 23, 23),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500)),
                                ],
                              )),
                          Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 246, 243, 255),
                                border: Border.all(
                                    width: .5,
                                    color: const Color.fromARGB(28, 0, 0, 0)),
                              ),
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Status: ",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 23, 23, 23),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500)),
                                  Text("$status",
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 23, 23, 23),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ))
                        ],
                      ))
                ])),
          ),
          Center(
              child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            width: MediaQuery.of(context).size.width * .85,
            height: MediaQuery.of(context).size.height * .1,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            child: Center(
                child: Text("$bookingcode",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600))),
          ))
        ]));
  }
}
