import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:yeekoo/functions/login.dart';
// import 'package:yeekoo/functions/trips.dart';

signup(fullname, number, email, password, repeatpassword, contextDialog,
    context) async {
  try {
    String api = 'https://opiononline.com/server_code/signup.php';

    var response = await http.post(Uri.parse(api), body: {
      'fullname': fullname,
      'number': number,
      'email': email,
      'password': password,
      'repeatpassword': repeatpassword,
      'mysecretesignup': 'yesssirconnect'
    });

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      if (data['success']) {
        login(number, password, contextDialog, context);
      } else {
        showErrorMessage(data['title'], data['message'], 'Try Again',
            contextDialog, context);
      }
    }

    return true;
    // print(responseData['message']);
  } on Exception catch (_) {
    showErrorMessage(
        "Connection Error",
        "Please check your internet connectivity and try again",
        'Try Again',
        contextDialog,
        context);
  }
}
