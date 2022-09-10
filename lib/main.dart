import 'package:flutter/material.dart';
// import 'signup.dart';
// import 'choose_station.dart';
// import 'dashboard.dart';
// import 'voucher.dart';
// import 'booking_details.dart';
import 'version_2/login.dart';
// import 'scratch/dashboard.dart';
// import 'version_2/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bus App",
      // home: SignupPage(),
      // home: VoucherPage(),
      // home: BookingPage(),,.
      home: LoginPage(),
      // home: Dashboard(),
      // home: Home(name: "Isaac Jacobson", number: "0552595712", list: const []),
      debugShowCheckedModeBanner: false,
    );
  }
}
