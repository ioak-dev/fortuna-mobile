import 'package:Expenso/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:Expenso/dashboard/dashboard_page.dart';
import 'package:Expenso/home/home_page.dart';
import 'package:Expenso/dashboard/login_page.dart';
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
      backgroundColor: Colors.white60,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/logo.png",height: 180,width: 200,),

            SizedBox(height: 16.0),
            SpinKitFadingCube(
              color: Colors.black,
              size: 40.0,
            ),
          ],
        ),
      ),
    );

  }
}

