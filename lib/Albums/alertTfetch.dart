import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<AlertT> fetchAlertT() async {
  final response =
      await http.get(Uri.parse('http://localhost:8089/pi/alert/temp'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return AlertT.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class AlertT {
  final int idAlert;
  final double temperature;

  const AlertT({
    required this.idAlert,
    required this.temperature,
  });

  factory AlertT.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'idAlert': int idAlert,
        'temperature': double temperature,
      } =>
        AlertT(
          idAlert: idAlert,
          temperature: temperature,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
