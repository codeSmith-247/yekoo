import 'package:flutter/material.dart';
import 'package:yeekoo/version_2/ticket.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

fetchtickets(name, email, number, context) async {
  // ignore: unused_local_variable
  dynamic result = '';

  var response = await http.post(
      Uri.parse('https://opiononline.com/server_code/fetchtickets.php'),
      body: {'number': "$number", "mygetattemptsecrete": ""});

  result = json.decode(response.body);

  if (response.statusCode == 200) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Ticket(
                list: result, name: name, email: email, number: number)));
  }
}
