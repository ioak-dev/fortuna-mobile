import 'dart:async';

import 'package:endurance/bloc/activity_bloc.dart';
import 'package:endurance/database/database_provider.dart';
import 'package:endurance/database/model/activity.dart';
import 'package:endurance/database/activity_repository.dart';
import 'package:endurance/preset/preset_run/preset_run_page.dart';
import 'package:endurance/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:numberpicker/numberpicker.dart';

import '../activity_edit/activity_edit_page.dart';

class ActivityViewPage extends StatefulWidget {
  const ActivityViewPage({Key? key, this.id, required this.presetId})
      : super(key: key);

  final int presetId;
  final int? id;

  @override
  State<ActivityViewPage> createState() => _ActivityViewPageState();
}

class _ActivityViewPageState extends State<ActivityViewPage> {
  late ActivityBloc activityBloc;
  StreamSubscription? activityBlocStream;
  Activity? activity;

  @override
  void initState() {
    super.initState();
    activityBloc = BlocProvider.of<ActivityBloc>(context);
    activityBlocStream = activityBloc.stream.listen((event) {
      readActivityFromState(event.activities);
    });
    readActivityFromState(activityBloc.state.activities);
  }

  void readActivityFromState(List<Activity> activities) {
    setState(() {
      activity = activities.firstWhere((element) => element.id == widget.id);
    });
  }

  @override
  void dispose() {
    // presetBloc.close();
    activityBlocStream?.cancel();
    super.dispose();
  }

  void closePage() {
    Navigator.pop(context);
  }

  void openEditPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ActivityEditPage(
                id: activity?.id, presetId: activity?.presetId ?? 0)));
  }

  void openRunPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PresetRunPage(
                  presetId: activity?.presetId ?? 0,
                  startFromActivityId: activity?.id,
                )));
  }

  Widget renderBody() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${activity?.hour.toString().padLeft(2, '0')}:${activity?.minute.toString().padLeft(2, '0')}:${activity?.second.toString().padLeft(2, '0')}",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 60),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(activity?.color ?? 000),
        foregroundColor:
            getFontColorForBackground(Color(activity?.color ?? 000)),
        title: Text(activity?.name ?? ''),
        centerTitle: true,
      ),
      body: renderBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        FloatingActionButton(
          heroTag: 'edit-activity',
          child: const Icon(Icons.edit),
          onPressed: () {
            openEditPage();
          },
        ),
        SizedBox(
          width: 20,
        ),
        FloatingActionButton(
          heroTag: 'run-activity',
          child: const Icon(Icons.play_arrow),
          onPressed: () {
            openRunPage();
          },
        )
      ]),
    );
  }
}
