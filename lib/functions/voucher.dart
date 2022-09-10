import 'package:flutter/material.dart';
// import 'package:yeekoo/version_2/ticket.dart';
import 'package:yeekoo/version_2/makepayment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

fetchvoucher(name, email, number, bookingcode, context) async {
  // ignore: unused_local_variable
  dynamic result = '';

  var response = await http.post(
      Uri.parse('https://opiononline.com/server_code/voucher.php'),
      body: {'bookingcode': "$bookingcode", "mygetattemptsecrete": ""});

  result = json.decode(response.body);

  if (response.statusCode == 200) {
    if (result.length > 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Makepayment(
                    station: result[0]['station'],
                    name: name,
                    number: number,
                    email: email,
                    tripid: result[0]['trip_id'],
                  )));
    } else {
      return false;
    }
  } else {
    return false;
  }
  return true;
}
