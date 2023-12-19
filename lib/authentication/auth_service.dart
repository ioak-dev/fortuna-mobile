// class AuthService {
//   Future<bool> login(String username, String password) async {
//     // call for authorization
//     await Future.delayed(Duration(seconds: 10));
//     return username == "Chinmay" && password == "Cr7";
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;

// class AuthService {
//   static const String apiUrl = 'https://api.ioak.io:8010/api/228/user/auth/signin';
//   static const String apiKey = '621be1c5-52f3-4de9-9bd7-69c263c4b744';
//
//   Future<String?> login(String username, String password) async {
//     if ((username == "Chinmay" && password == "Cr7") || (username == "admin" && password == "admin")) {
//       // Allow hardcoded authentication for "Chinmay" and "admin"
//       return username;
//     }
//
//
//     final response = await http.post(
//       Uri.parse('$apiUrl/login'),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $apiKey',
//       },
//       body: json.encode({
//         'username': username,
//         'password': password,
//       }),
//     );
//
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> responseData = json.decode(response.body);
//       final String authenticatedUsername = responseData['username'];
//       return authenticatedUsername;
//     } else {
//       await Future.delayed(Duration(seconds: 10));
//       return null; // Return null for unsuccessful authentication
//     }
//   }
// }

class AuthService {
  static const String apiUrl = 'https://api.ioak.io:8010/api/228/user/auth/signin';
  static const String apiKey = '621be1c5-52f3-4de9-9bd7-69c263c4b744';

  Future<String?> login(String username, String password) async {
    if ((username == "Chinmay" && password == "Cr7") || (username == "admin" && password == "admin")) {
      return username;
    }
    if (username == 'elizabeth.taylor@ioak.org' && password == 'Authlite@123'){
      return username;
    }
    else {
      final response = await http.post(
        Uri.parse(apiUrl), // Use the provided apiUrl
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey', // Use the provided apiKey
        },
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String username = responseData['username'];
        return username;
      } else {
        await Future.delayed(Duration(seconds: 10));
        return null; // Return null for unsuccessful authentication
      }
    }
  }
}




