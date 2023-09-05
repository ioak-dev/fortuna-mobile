import 'dart:async';

import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:provider/provider.dart';

import '../theme/ThemeManager.dart';

class TimerPage extends StatefulWidget {
  // const TimerPage({Key? key}) : super(key: key);

  @override
//   State<TimerPage> createState() => _TimerPageState();
// }
//
// class _TimerPageState extends State<TimerPage> {
//   int _currentIndex = 0;

  // void _incrementCounter(int index) {
  //   setState(() {
  //     _currentIndex = index;
  //   });
  // }

  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerPage> {
  int _seconds = 0;
  bool _isRunning = false;
  List<String> _recordedTimings = [];
  Timer? _timer;

  void _startTimer() {
    setState(() {
      _isRunning = true;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _stopTimer() {
    setState(() {
      _isRunning = false;
    });

    _timer?.cancel();
  }

  void _resetTimer() {
    setState(() {
      _seconds = 0;
      _isRunning = false;
      _recordedTimings.clear();
    });

    _timer?.cancel();
  }

  void _recordTiming() {
    setState(() {
      _recordedTimings.add(_formattedTime());
    });
  }

  String _formattedTime() {
    int minutes = _seconds ~/ 60;
    int seconds = _seconds % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeManager>(context).themeData,
        title: 'Timer',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Timer'),
          ),
            body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("images/timer.gif",height: 180,width: 180,),
        Text(
          _formattedTime(),
          style: TextStyle(fontSize: 48,color: Colors.black87,fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _isRunning ? _stopTimer : _startTimer,
              child: Text(_isRunning ? 'Stop' : 'Start'),
            ),
            SizedBox(width: 20),
            ElevatedButton(
              onPressed: _isRunning ? _recordTiming : null,
              child: Text('Record',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            ),
            SizedBox(width: 20),
            ElevatedButton(
              onPressed: _resetTimer,
              child: Text('Reset'),
            ),
          ],
        ),
        SizedBox(height: 20),
        if (_recordedTimings.isNotEmpty)
          Column(
            children: [
              Text(
                'Recorded Timings:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Column(
                children: _recordedTimings
                    .map((timing) => Text(
                  timing,
                  style: TextStyle(fontSize: 16),
                ))
                    .toList(),
              ),
            ],
          ),
      ],
    ),
    ),
    );
  }
}