import 'package:http/http.dart' as http;
import 'dart:convert';

getTrips(location, destination, stop) async {
  stop = "$stop";
  try {
    dynamic result = '';
    var response = await http.post(
        Uri.parse("https://opiononline.com/server_code/trips.php"),
        body: {
          'mygetattemptsecrete': 'password',
          'location': location ?? "",
          'destination': destination ?? "",
          'start': stop ?? '0',
        });

    if (response.statusCode == 200) {
      result = json.decode(response.body);
      // var test = result;
      // print(result);
      return result;
    }

    return ['something is wrong'];
  } on Exception catch (_) {
    return ['something is wrong'];
  }
}
