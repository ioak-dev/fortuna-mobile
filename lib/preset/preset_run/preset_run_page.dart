import 'dart:async';

import 'package:endurance/bloc/activity_bloc.dart';
import 'package:endurance/bloc/preset_bloc.dart';
import 'package:endurance/database/database_provider.dart';
import 'package:endurance/database/model/activity.dart';
import 'package:endurance/database/activity_repository.dart';
import 'package:endurance/database/model/preset.dart';
import 'package:endurance/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:wakelock/wakelock.dart';

class PresetRunPage extends StatefulWidget {
  const PresetRunPage(
      {Key? key, required this.presetId, this.startFromActivityId})
      : super(key: key);

  final int presetId;
  final int? startFromActivityId;

  @override
  State<PresetRunPage> createState() => _PresetRunPageState();
}

class _PresetRunPageState extends State<PresetRunPage> {
  late ActivityBloc activityBloc;
  StreamSubscription? activityBlocStream;
  List<Activity> activities = [];
  List<Activity> remainingActivities = [];
  Activity? activity;
  Timer? timer;
  Duration duration = const Duration(seconds: 0);
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    activityBloc = BlocProvider.of<ActivityBloc>(context);
    activityBlocStream = activityBloc.stream.listen((event) {
      readActivitiesFromState(event.activities);
    });
    readActivitiesFromState(activityBloc.state.activities);
    startTimer();
  }

  void readActivitiesFromState(List<Activity> activities) {
    List<Activity> activitiesForPreset = activities
        .where((element) => element.presetId == widget.presetId)
        .toList();
    if (widget.startFromActivityId != null) {
      final int index = activitiesForPreset
          .indexWhere((element) => element.id == widget.startFromActivityId);
      activitiesForPreset = activitiesForPreset.sublist(index);
    }
    setState(() {
      activities = activitiesForPreset;
      remainingActivities = activitiesForPreset;
    });
  }

  void startTimer() {
    if (remainingActivities.length > currentIndex) {
      setState(() {
        activity = remainingActivities[currentIndex];
        duration = Duration(
            hours: remainingActivities[currentIndex].hour,
            minutes: remainingActivities[currentIndex].minute,
            seconds: remainingActivities[currentIndex].second);
      });
      Wakelock.enable();
      timer = Timer.periodic(Duration(seconds: 1), (_) {
        setCountDown();
      });
    }
  }

  void setCountDown() {
    setState(() {
      final seconds = duration.inSeconds - 1;
      if (seconds < 0) {
        timer!.cancel();
        currentIndex = currentIndex + 1;
        startTimer();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  @override
  void dispose() {
    // presetBloc.close();
    Wakelock.disable();
    timer?.cancel();
    activityBlocStream?.cancel();
    super.dispose();
  }

  void back() {
    Navigator.pop(context);
  }

  void pause() {
    Wakelock.disable();
    timer?.cancel();
    setState(() => timer = timer);
  }

  void resume() {
    Wakelock.enable();
    setState(() {
      timer = Timer.periodic(Duration(seconds: 1), (_) {
        setCountDown();
      });
    });
  }

  void previous() {
    if (currentIndex != 0) {
      setState(() {
        timer?.cancel();
        currentIndex = currentIndex - 1;
        startTimer();
      });
    }
  }

  void next() {
    if (currentIndex < remainingActivities.length - 1) {
      setState(() {
        timer?.cancel();
        currentIndex = currentIndex + 1;
        startTimer();
      });
    }
  }

  void resetActivity() {
    Wakelock.enable();
    setState(() {
      duration = Duration(
          hours: remainingActivities[currentIndex].hour,
          minutes: remainingActivities[currentIndex].minute,
          seconds: remainingActivities[currentIndex].second);
      timer?.cancel();
      timer = Timer.periodic(Duration(seconds: 1), (_) {
        setCountDown();
      });
    });
  }

  void stop() {}

  Widget renderBody(PresetState state) {
    Preset preset =
        state.presets.firstWhere((element) => element.id == widget.presetId);
    return AnimatedContainer(
      color:
          activity == null ? Colors.transparent : Color(activity?.color ?? 0),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
      duration: const Duration(milliseconds: 250),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            GestureDetector(
                onTap: () => back(),
                child: Icon(Icons.arrow_back,
                    size: 24,
                    color: getFontColorForBackground(
                        Color(activity?.color ?? 000)))),
            Text(
              preset.name,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color:
                      getFontColorForBackground(Color(activity?.color ?? 000))),
            ),
            SizedBox()
          ]),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  activity?.name ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: getFontColorForBackground(
                          Color(activity?.color ?? 0))),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${duration.inHours.toString().padLeft(2, '0')}:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 60,
                      color: getFontColorForBackground(
                          Color(activity?.color ?? 0))),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  currentIndex != 0
                      ? GestureDetector(
                          child: Icon(
                            Icons.skip_previous,
                            color: getFontColorForBackground(
                                Color(activity?.color ?? 000)),
                          ),
                          onTap: () => previous(),
                        )
                      : Icon(
                          Icons.skip_previous,
                          color: Color(activity?.color ?? 000),
                        ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: Icon(Icons.refresh,
                        color: getFontColorForBackground(
                            Color(activity?.color ?? 000))),
                    onTap: () => resetActivity(),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  currentIndex < remainingActivities.length - 1
                      ? GestureDetector(
                          child: Icon(
                            Icons.skip_next,
                            color: getFontColorForBackground(
                                Color(activity?.color ?? 000)),
                          ),
                          onTap: () => next(),
                        )
                      : Icon(
                          Icons.skip_next,
                          color: Color(activity?.color ?? 000),
                        )
                ])
              ])
            ],
          ))
        ],
      ),
    );
  }

  Widget renderFloatingAction() {
    Widget playPause = FloatingActionButton(
      heroTag: 'resume',
      child: const Icon(Icons.play_arrow),
      onPressed: () {
        resume();
      },
    );
    print('timer?.isActive');
    print(timer?.isActive);
    if (timer?.isActive != null && timer?.isActive == true) {
      playPause = FloatingActionButton(
        heroTag: 'pause',
        child: const Icon(Icons.pause),
        onPressed: () {
          pause();
        },
      );
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.center, children: [playPause]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Color(activity?.color ?? 000),
      //   foregroundColor:
      //       getFontColorForBackground(Color(activity?.color ?? 000)),
      //   title: Text(activity?.name ?? ''),
      //   centerTitle: true,
      // ),
      body: BlocBuilder<PresetBloc, PresetState>(builder: (context, state) {
        return renderBody(state);
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: renderFloatingAction(),
    );
  }
}
