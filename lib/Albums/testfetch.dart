import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Test> fetchTest() async {
  final response =
      await http.get(Uri.parse('http://localhost:8089/pi/bee/count-bee'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Test.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Test {
  final int idBee;
  final String number;

  const Test({
    required this.idBee,
    required this.number,
  });

  factory Test.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'idBee': int idBee,
        'number': String number,
      } =>
        Test(
          idBee: idBee,
          number: number,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
