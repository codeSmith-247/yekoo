// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:yeekoo/functions/trips.dart';
import 'package:yeekoo/version_2/home.dart';

// import 'dart:io';

login(number, password, contextDialog, context) async {
  if (number.length == 0 || password.length == 0) {
    showErrorMessage(
        "Empty Input",
        "Please type your telephone number and password and try agian",
        'Try Again',
        contextDialog,
        context);
    return true;
  }

  await Future.delayed(const Duration(seconds: 1));

  try {
    String api = 'https://opiononline.com/server_code/login.php';
    var response = await http.post(Uri.parse(api), body: {
      'number': number,
      'password': password,
    });

    if (response.statusCode == 200) {
      
      dynamic locationlist = await getTrips('', '', 0);
      var responseData = json.decode(response.body);
      if (loginActions(responseData, contextDialog, context, locationlist)) {
        return true;
      }
      
    } else {
      showErrorMessage(
          "Connection Error",
          "Please check your internet connectivity and try again",
          'Try Again',
          contextDialog,
          context);
    }
  } on Exception catch (_) {
    showErrorMessage(
        "Connection Error",
        "Please check your internet connectivity and try again",
        'Try Again',
        contextDialog,
        context);
  }

  return false;
}

bool loginActions(response, contextDialog, context, locationlist) {
  //placed show error here so that loader would show irrespective of post response

  if (response['success'] == true) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => Home(
                name: response['fullname'],
                number: response['number'],
                email: response['email'],
                list: locationlist,
              )),
    );
    return true;
  }

  showErrorMessage("Failed Login Attempt", response['message'], 'Try Again',
      contextDialog, context);

  return false;
}

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
