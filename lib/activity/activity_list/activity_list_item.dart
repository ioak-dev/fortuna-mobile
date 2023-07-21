import 'package:endurance/activity/activity_edit/activity_edit_page.dart';
import 'package:endurance/activity/activity_view/activity_view_page.dart';
import 'package:endurance/database/model/activity.dart';
import 'package:endurance/shared/utils.dart';
import 'package:flutter/material.dart';

class ActivityListItem extends StatelessWidget {
  ActivityListItem({Key? key, required this.activity}) : super(key: key);

  Activity activity;

  handleClick(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ActivityViewPage(
                id: activity.id, presetId: activity.presetId)));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color(activity.color)),
        alignment: Alignment.centerLeft,
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
        child: Column(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        activity.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: getFontColorForBackground(
                                Color(activity.color))),
                      ),
                      Text(
                        'C',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: getFontColorForBackground(
                                Color(activity.color))),
                      )
                    ])),
            Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${activity.hour}h ${activity.minute}m ${activity.second}s",
                      style: TextStyle(
                          color:
                              getFontColorForBackground(Color(activity.color))),
                    )
                  ],
                ))
          ],
        ),
      ),
      onTap: () {
        handleClick(context);
      },
    );
  }
}
