import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:yeekoo/functions/fetchtickets.dart';

maketicket(name, email, station, amount, voucher, tripid, number, seats, time,
    context) async {
  dynamic newamount = amount * double.parse(seats);
  // var response = await http.post(
  //     Uri.parse('https://opiononline.com/server_code/maketicket.php'),
  //     body: {
  //       'station': "$station",
  //       'amount': "$newamount",
  //       'voucher': "$voucher",
  //       'tripid': "$tripid",
  //       'number': "$number",
  //       'seats': "$seats",
  //       'mygetattemptsecrete': 'yesssirconnect'
  //     });

  var response = await http.post(
      Uri.parse('https://opiononline.com/server_code/maketicket.php'),
      body: {
        'station': "$station",
        'amount': "$newamount",
        'voucher': "$voucher",
        'tripid': "$tripid",
        'number': "$number",
        'seats': "$seats",
        'time': "$time",
        'mygetattemptsecrete': 'yesssirconnect'
      });

  if (response.statusCode == 200) {
    // var result = json.decode(response.body);
    fetchtickets(name, email, number, context);
  } else {
   
    return false;
  }
}
