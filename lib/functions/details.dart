import 'package:http/http.dart' as http;
import 'dart:convert';

getDetails(tripid) async {
  try {
    dynamic result = '';
    var response = await http.post(
        Uri.parse("https://opiononline.com/server_code/booking_details.php"),
        body: {
          'mygetattemptsecrete': 'password',
          'trip_id': '$tripid',
        });

    if (response.statusCode == 200) {
      result = json.decode(response.body);
      
      return result;
    }

    return ['something is wrong'];
  } on Exception catch (_) {
    return ['something is wrong'];
  }
}
