import 'package:endurance/bloc/activity_bloc.dart';
import 'package:endurance/database/model/activity.dart';
import 'package:endurance/database/model/preset.dart';
import 'package:endurance/preset/preset_view/preset_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/preset_bloc.dart';

class PresetListItem extends StatelessWidget {
  PresetListItem({Key? key, required this.preset}) : super(key: key);

  Preset preset;

  handleClick(context) {
    print(preset);
    print("*");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PresetViewPage(id: preset.id ?? 0)));
  }

  Widget renderBody(ActivityState state) {
    List<Activity> activities = state.activities
        .where((element) => element.presetId == preset.id)
        .toList();
    int restCount = activities
        .where((element) => element.name.toLowerCase() == 'rest')
        .length;
    int seconds = 0;
    activities.forEach((element) {
      seconds += element.second;
      seconds += element.minute * 60;
      seconds += element.hour * 60 * 60;
    });
    Duration duration = Duration(seconds: seconds);

    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
      child: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      preset.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                        "${duration.inHours}h ${duration.inMinutes.remainder(60)}m ${duration.inSeconds.remainder(60)}s",
                        textAlign: TextAlign.start)
                  ])),
          SizedBox(height: 2,),
          Align(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "${activities.length - restCount} interval${activities.length - restCount != 1 ? "s" : ""}${restCount > 0 ? ",  ${restCount} rest${restCount != 1 ? "s" : ""}" : ""}")
                ],
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child:
          BlocBuilder<ActivityBloc, ActivityState>(builder: (context, state) {
        return renderBody(state);
      }),
      onTap: () {
        handleClick(context);
      },
    );
  }
}
