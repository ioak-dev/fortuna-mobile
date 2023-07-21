import 'package:endurance/preset/preset_list/preset_list.dart';
import 'package:endurance/database/model/preset.dart';
import 'package:endurance/preset/preset_list/preset_new.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class PresetListPage extends StatefulWidget {
  const PresetListPage({Key? key}) : super(key: key);

  @override
  State<PresetListPage> createState() => _PresetListPageState();
}

class _PresetListPageState extends State<PresetListPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter = _counter + 1;
    });
  }

  @override
  void initState() {
    super.initState();
    print('Widget Lifecycle: initState');
  }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890    ';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  void openAddPage() {
    Navigator.pushNamed(context, '/preset/create');
    // return showModalBottomSheet(
    //     shape: const RoundedRectangleBorder(
    //         borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
    //     isScrollControlled: true,
    //     context: context,
    //     builder: (context) {
    //       return Wrap(children: const [PresetNew()]);
    //     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preset list"),
        elevation: 0,
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  openAddPage();
                },
                child: Icon(Icons.add),
              ))
        ],
      ),
      body: Container(
          child: Column(
        children: [
          PresetList(),
        ],
      )),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     openAddPage();
      //   },
      //   backgroundColor: Colors.grey,
      // ),
    );
  }
}
