import 'dart:async';

import 'package:endurance/bloc/activity_bloc.dart';
import 'package:endurance/database/database_provider.dart';
import 'package:endurance/database/model/activity.dart';
import 'package:endurance/database/activity_repository.dart';
import 'package:endurance/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:numberpicker/numberpicker.dart';

class ActivityEditPage extends StatefulWidget {
  const ActivityEditPage({Key? key, this.id, required this.presetId})
      : super(key: key);

  final int presetId;
  final int? id;

  @override
  State<ActivityEditPage> createState() => _ActivityEditPageState();
}

class _ActivityEditPageState extends State<ActivityEditPage> {
  Color pickerColor = Color(0xff29b6f6);
  Color currentColor = Color(0xff29b6f6);
  late ActivityBloc activityBloc;
  StreamSubscription? activityBlocStream;
  Activity? activity;

  void changeColor(Color color) {
    setState(() => pickerColor = color);
    setState(() => currentColor = color);
    Navigator.of(context).pop();
  }

  var nameController = TextEditingController();

  void refreshActivities() {
    activityBloc.add(FetchActivities());
  }

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
    Activity initialActivity;
    if (widget.id != null) {
      initialActivity =
          activities.firstWhere((element) => element.id == widget.id);
    } else {
      initialActivity = Activity(
          name: '',
          presetId: widget.presetId,
          hour: 0,
          minute: 0,
          second: 0,
          sortOrder: 0,
          color: currentColor.value);
    }
    setState(() {
      activity = initialActivity;
      currentColor = Color(initialActivity.color);
    });
    nameController.text = initialActivity.name;
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

  void saveActivity() async {
    activity?.color = currentColor.value;
    if (activity?.id != null) {
      await ActivityRepository.update(activity!);
    } else {
      final activityBloc = BlocProvider.of<ActivityBloc>(context);
      activity?.sortOrder = activityBloc.state.activities
          .where((element) => element.presetId == widget.presetId)
          .length;
      await ActivityRepository.create(activity!);
    }
    refreshActivities();
    Navigator.pop(context);
  }

  Widget renderColorPicker() {
    return GestureDetector(
        child: Container(
          width: double.infinity,
          height: 60,
          child: Icon(Icons.format_color_fill,
              color: getFontColorForBackground(Color(activity?.color ?? 0))),
          decoration: BoxDecoration(
              color: currentColor,
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Pick a color!'),
              content: SingleChildScrollView(
                child: MaterialPicker(
                    pickerColor: pickerColor, onColorChanged: changeColor),
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('Close'),
                  onPressed: () {
                    setState(() => currentColor = pickerColor);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget renderBody() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(children: [
        TextField(
            decoration: InputDecoration(labelText: "Activity name"),
            controller: nameController,
            autofocus: true,
            onChanged: (value) => setState(() => activity?.name = value)),
        SizedBox(
          height: 40,
        ),
        renderColorPicker(),
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: NumberPicker(
                  infiniteLoop: true,
                  minValue: 0,
                  maxValue: 96,
                  haptics: true,
                  value: activity?.hour ?? 0,
                  onChanged: (value) => setState(() => activity?.hour = value)),
            ),
            Expanded(
                child: NumberPicker(
                    infiniteLoop: true,
                    minValue: 0,
                    maxValue: 60,
                    haptics: true,
                    value: activity?.minute ?? 0,
                    onChanged: (value) =>
                        setState(() => activity?.minute = value))),
            Expanded(
                child: NumberPicker(
                    infiniteLoop: true,
                    minValue: 0,
                    maxValue: 60,
                    haptics: true,
                    value: activity?.second ?? 0,
                    onChanged: (value) =>
                        setState(() => activity?.second = value)))
          ],
        ),
        Expanded(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        "${activity?.hour}h ${activity?.minute}m ${activity?.second}s")
                  ],
                )))
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(activity?.name ?? 'New activity'),
            centerTitle: true,
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      saveActivity();
                    },
                    child: Icon(Icons.check),
                  ))
            ]),
        body: renderBody());
  }
}
