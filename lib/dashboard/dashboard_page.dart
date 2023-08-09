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

    bool isUserAuthenticated = true;
    if (!isUserAuthenticated) {
      return LoginPage();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(0),
        //   child: NewGradientAppBar(
        //     title: Text('Dashboard'),
        //     gradient: LinearGradient(
        //       colors: [
        //         Colors.blueGrey,
        //         Colors.grey,
        //       ],
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //     ),
        //   ),
        // ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // name :>
              Container(
                alignment: Alignment.center,
                child: TyperAnimatedTextKit(
                  text: ['Hi, ${widget.username}!'],
                  textStyle: TextStyle(

                    color: Colors.white,
                    fontSize: 24,
                  ),
                  speed: Duration(milliseconds: 100),
                  isRepeatingAnimation: false,
                ),
              ),


              SizedBox(height: 20),
              //2nd
              CircleAvatar(
                radius: 120,
                backgroundImage: AssetImage("images/Chinmay_Sharma.jpg"),
              ),
              SizedBox(height: 20),


              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(50), // Half of the height makes it oval
                ),
                alignment: Alignment.center,
                child: Text("Candidate 3", style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              SizedBox(height: 20),

              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(50), // Half of the height makes it oval
                ),
                alignment: Alignment.center,
                child: Text("Candidate 4", style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
