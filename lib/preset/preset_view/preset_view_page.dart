import 'dart:async';

import 'package:endurance/activity/activity_edit/activity_edit_page.dart';
import 'package:endurance/activity/activity_list/activity_list.dart';
import 'package:endurance/bloc/preset_bloc.dart';
import 'package:endurance/database/database_provider.dart';
import 'package:endurance/database/model/preset.dart';
import 'package:endurance/preset/preset_run/preset_run_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PresetViewPage extends StatefulWidget {
  const PresetViewPage({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<PresetViewPage> createState() => _PresetViewPageState();
}

class _PresetViewPageState extends State<PresetViewPage> {
  Preset? preset;
  var nameController = new TextEditingController();

  void addActivity(Preset preset) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ActivityEditPage(presetId: preset.id ?? 0)));
  }

  void closePage() {
    Navigator.pop(context);
  }

  void openRunPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PresetRunPage(presetId: widget.id)));
  }

  renderAppbar(PresetState state) {
    final Preset preset =
        state.presets.firstWhere((element) => element.id == widget.id);
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(preset.name),
      centerTitle: true,
      actions: [
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                addActivity(preset);
              },
              child: Icon(Icons.add),
            ))
      ],
    );
  }

  Widget renderBody() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ActivityList(presetId: widget.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PresetBloc, PresetState>(builder: (context, state) {
      return Scaffold(
        appBar: renderAppbar(state),
        body: renderBody(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.play_arrow),
          onPressed: () {
            openRunPage();
          },
        ),
      );
    });
  }
}
