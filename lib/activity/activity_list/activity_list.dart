import 'package:endurance/bloc/activity_bloc.dart';
import 'package:endurance/database/activity_repository.dart';
import 'package:endurance/database/database_provider.dart';
import 'package:endurance/activity/activity_list/activity_list_item.dart';
import 'package:endurance/database/model/activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityList extends StatefulWidget {
  const ActivityList({Key? key, required this.presetId}) : super(key: key);

  final int presetId;

  @override
  State<ActivityList> createState() => _ActivityListState();
}

class _ActivityListState extends State<ActivityList> {
  List<Activity> activities = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshActivities();
  }

  void reorder(List<Activity> activities, int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) {
      newIndex = newIndex - 1;
    }

    for (int i = 0; i < activities.length; i++) {
      final Activity activity = activities[i];

      if (i == oldIndex) {
        activity.sortOrder = newIndex;
        await ActivityRepository.update(activity);
      } else if (oldIndex > newIndex) {
        if (i >= newIndex && i < oldIndex) {
          activity.sortOrder = activity.sortOrder + 1;
          await ActivityRepository.update(activity);
        }
      } else if (oldIndex < newIndex) {
        if (i > oldIndex && i <= newIndex) {
          activity.sortOrder = activity.sortOrder - 1;
          await ActivityRepository.update(activity);
        }
      }
    }
    final activityBloc = BlocProvider.of<ActivityBloc>(context);
    activityBloc.add(FetchActivities());
    // ActivityRepository.update(activity)
  }

  void refreshActivities() async {
    final activityBloc = BlocProvider.of<ActivityBloc>(context);
    activityBloc.add(FetchActivities());
  }

  Widget renderList(ActivityState state) {
    List<Activity> activities = state.activities
        .where((element) => element.presetId == widget.presetId)
        .toList();
    return ReorderableListView.builder(
      itemCount: activities.length,
      itemBuilder: (context, index) {
        return ActivityListItem(
            key: ValueKey(activities[index].id), activity: activities[index]);
      },
      onReorder: (int oldIndex, int newIndex) {
        reorder(activities, oldIndex, newIndex);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityBloc, ActivityState>(builder: (context, state) {
      return renderList(state);
    });
  }
}
