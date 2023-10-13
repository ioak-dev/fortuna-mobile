import 'package:endurance/dashboard/login_page.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:endurance/authentication/auth_service.dart';

class DashboardPage extends StatefulWidget {
  final String username;
  const DashboardPage({Key? key, required this.username}) : super(key: key);
  // const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

  void _incrementCounter(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isUserAuthenticated = true; // Should handle the actual authentication state
    bool isChinmay = widget.username == "Chinmay";

    if (!isUserAuthenticated) {
      return LoginPage();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.center,
                child: TyperAnimatedTextKit(
                  text: ['Hi, ${widget.username}!'],
                  textStyle: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 24,
                  ),
                  speed: Duration(milliseconds: 250),
                  isRepeatingAnimation: false,
                ),
              ),
              SizedBox(height: 20),
              // Conditionally show CircleAvatar if the username is "Chinmay"
              if (isChinmay)
                CircleAvatar(
                  radius: 120,
                  backgroundImage: AssetImage("images/Chinmay_Sharma.jpg"),
                ),
              if (!isChinmay) // not Chinmay Other User
                Icon(
                  Icons.person,
                  size: 120,
                  color: Colors.grey,
                ),
              SizedBox(height: 20),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: Scaffold(body: DashboardPage(username: 'Chinmay'))));
}
