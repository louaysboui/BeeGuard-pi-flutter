import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  Future<http.Response> loginUser(String email, String password) async {
    // Define the URI for the login endpoint
    var uri = Uri.parse('http://localhost:8089/pi/user/login');

    // Define headers for the request
    Map<String, String> headers = {'Content-Type': 'application/json'};

    // Create a map containing email and password
    Map<String, String> data = {'email': email, 'password': password};

    // Convert the data into JSON
    var body = json.encode(data);

    // Send a POST request to the server
    var response = await http.post(uri, headers: headers, body: body);

    // Print the response body
    print(response.body);

    return response;
  }
}
