import 'package:endurance/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:endurance/dashboard/dashboard_page.dart';
import 'package:endurance/home/home_page.dart';
import 'package:endurance/dashboard/login_page.dart';
class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}
class _LoadingPageState extends State<LoadingPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(Duration(seconds: 5), () {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/logo.png",height: 180,width: 180,),

            SizedBox(height: 16.0),
            SpinKitFadingCube(
              color: Colors.blueAccent,
              size: 40.0,
            ),
          ],
        ),
      ),
    );

  }
}

