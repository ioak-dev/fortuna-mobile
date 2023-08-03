import 'package:endurance/dashboard/login_page.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

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
    // Check if the user is authenticated, if not, show the LoginPage.
    // Replace 'isUserAuthenticated' with your actual authentication check logic.
    bool isUserAuthenticated = true; // Change to 'false' to simulate an unauthenticated user.
    if (!isUserAuthenticated) {
      return LoginPage();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        // Uncomment the code below if you want to use the NewGradientAppBar
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
              // First Candidate
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                child: Text("Candidate 1", style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              SizedBox(height: 20),
              //2nd
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                child: Text("Candidate 2", style: TextStyle(color: Colors.white, fontSize: 20)),
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
