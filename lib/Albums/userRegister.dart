import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Service {
  //create the method to save user

  Future<http.Response> saveUser(
      String username, String email, String password) async {
    //create uri
    var uri = Uri.parse("http://localhost:8089/pi/user/register");
    //header
    Map<String, String> headers = {"Content-Type": "application/json"};
    //body
    Map data = {
      'username': username,
      'email': email,
      'password': password,
    };
    //convert the above data into json
    var body = json.encode(data);
    var response = await http.post(uri, headers: headers, body: body);

    //print the response body
    print(response.body);

    return response;
  }
}
