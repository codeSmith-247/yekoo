import 'package:http/http.dart' as http;
import 'dart:convert';

getStations(tripid, start, name) async {
  dynamic result = '';
  var response = await http.post(
      Uri.parse('https://opiononline.com/server_code/stations.php'),
      body: {
        'trip_id': "$tripid",
        'start': "$start",
        'name': "$name",
        "mygetattemptsecrete": ""
      });

  if (response.statusCode == 200) {
    // print(response.body);
    result = json.decode(response.body);
    return result;
  }

  return false;
}
