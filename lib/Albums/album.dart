import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('http://localhost:8089/pi/temp-hum/sensor-temp-hum'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int idTemp;
  // ignore: non_constant_identifier_names
  final String TempVal;
  // ignore: non_constant_identifier_names
  final String HumVal;

  const Album({
    required this.idTemp,
    required this.TempVal,
    required this.HumVal,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'idTemp': int idTemp,
        'tempVal': String TempVal,
        'humVal': String HumVal,
      } =>
        Album(
          idTemp: idTemp,
          TempVal: TempVal,
          HumVal: HumVal,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
