import 'package:flutter/material.dart';
import 'package:yeekoo/version_2/login.dart';
import 'package:yeekoo/version_2/home.dart';
import 'package:yeekoo/version_2/voucher.dart';
import 'package:yeekoo/functions/trips.dart';
import 'package:yeekoo/functions/fetchtickets.dart';

dynamic bottomouterlocationList;

fetch() async {
  bottomouterlocationList = await getTrips('', '', 0);
}

class BottomNavigation extends StatelessWidget {
  final dynamic fullname;
  final dynamic number;
  final dynamic email;
  final dynamic locationList;
  BottomNavigation(
      {super.key, this.fullname, this.number, this.email, this.locationList}) {
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      IconButton(
          color: Colors.white,
          icon: const Icon(Icons.directions_bus_outlined),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Home(
                          name: '$fullname',
                          number: '$number',
                          email: '$email',
                          list: bottomouterlocationList,
                        )));
          }),
      IconButton(
          color: Colors.white,
          icon: const Icon(Icons.local_offer_outlined),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Voucher()),
            );
          }),
      IconButton(
          color: Colors.white,
          icon: const Icon(Icons.receipt_long_outlined),
          onPressed: () async {
            await fetchtickets(fullname, email, number, context);
          }),
      IconButton(
          color: Colors.white,
          icon: const Icon(Icons.cancel_outlined),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          }),
    ]);
  }
}
