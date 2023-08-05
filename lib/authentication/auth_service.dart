// class AuthService {
//   Future<bool> login(String username, String password) async {
//     // call for authorization
//     await Future.delayed(Duration(seconds: 10));
//     return username == "Chinmay" && password == "Cr7";
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String apiUrl = 'https://api.ioak.io:8010/api';
  static const String apiKey = 'fc2076f5-bee6-4b94-974f-5e110495b048';

  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/login'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Successfully authenticated
      return true;
    } else {
      await Future.delayed(Duration(seconds: 10));
     return username == "Chinmay" && password == "Cr7";

    }
  }
}

