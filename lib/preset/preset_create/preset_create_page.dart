import 'package:endurance/bloc/preset_bloc.dart';
import 'package:endurance/database/database_provider.dart';
import 'package:endurance/database/model/preset.dart';
import 'package:endurance/database/preset_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePresetPage extends StatefulWidget {
  const CreatePresetPage({Key? key}) : super(key: key);

  @override
  State<CreatePresetPage> createState() => _CreatePresetPageState();
}

class _CreatePresetPageState extends State<CreatePresetPage> {
  int _currentIndex = 0;
  var nameController = new TextEditingController();

  void _incrementCounter(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void refreshPresets() {
    final presetBloc = BlocProvider.of<PresetBloc>(context);
    presetBloc.add(FetchPresets());
  }

  void closePage() {
    Navigator.pop(context);
  }

  void savePreset() async {
    await PresetRepository.create(Preset(name: nameController.text));
    refreshPresets();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text('New preset'),
          centerTitle: true,
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    savePreset();
                  },
                  child: Icon(Icons.check),
                ))
          ],
          // leading: GestureDetector(
          //   onTap: () {
          //     closePage();
          //   },
          //   child: Icon(Icons.close),
          // )
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            TextField(controller: nameController),
          ]),
        ));
  }
}
