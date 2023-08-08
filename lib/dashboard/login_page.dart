// import 'package:endurance/authentication/auth_service.dart';
// import 'package:endurance/dashboard/dashboard_page.dart';
// import 'package:endurance/home/home_page.dart';
// import 'package:flutter/material.dart';
//
// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final AuthService _authService = AuthService();
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   bool _isLoading = false;
//   String _errorMessage = "";
//
//   void _login() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = "";
//     });
//
//     String username = _usernameController.text.trim();
//     String password = _passwordController.text.trim();
//
//     bool isAuthenticated = await _authService.login(username, password);
//
//     if (isAuthenticated) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomePage(title: 'Home Page')),
//       );
//     } else {
//       setState(() {
//         _isLoading = false;
//         _errorMessage = "Invalid username or password.";
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//       ),
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset("images/logo.png", height: 100, width: 100,),
//               Text(
//                 'Login Page',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 controller: _usernameController,
//                 decoration: InputDecoration(labelText: 'Username'),
//               ),
//               SizedBox(height: 10),
//               TextField(
//                 controller: _passwordController,
//                 obscureText: true,
//                 decoration: InputDecoration(labelText: 'Password'),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _isLoading ? null : _login,
//                 child: _isLoading ? CircularProgressIndicator() : Text('Login'),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 _errorMessage,
//                 style: TextStyle(color: Colors.red),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:endurance/authentication/auth_service.dart';
import 'package:endurance/dashboard/dashboard_page.dart';
import 'package:endurance/home/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = "";

  void _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = "";
    });

    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    String? authenticatedUsername = await _authService.login(username, password);

    if (authenticatedUsername == "Chinmay" && password == "Cr7") {
      // Allow hardcoded authentication
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(title: 'Home Page', username: username),
        ),
      );
    } else if (authenticatedUsername != null) {
      // Authenticate via API
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(title: 'Home Page', username: authenticatedUsername),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
        _errorMessage = "Invalid username or password.";
      });
    }
  }








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/logo.png", height: 100, width: 100,),
              Text(
                'Login Page',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _login,
                child: _isLoading ? CircularProgressIndicator() : Text('Login'),
              ),
              SizedBox(height: 10),
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
