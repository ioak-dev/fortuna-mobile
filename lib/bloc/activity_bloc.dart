import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:endurance/database/activity_repository.dart';
import 'package:endurance/database/database_provider.dart';
import 'package:endurance/database/model/activity.dart';
import 'package:equatable/equatable.dart';

part 'activity_event.dart';

part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  ActivityBloc() : super(const ActivityState()) {
    on<FetchActivities>(_mapFetchActivitiesEventToState);
  }

  void _mapFetchActivitiesEventToState(
      FetchActivities event, Emitter<ActivityState> emit) async {
    print("fetching activities");
    emit(state.copyWith(isLoading: true));
    List<Activity> activities = await ActivityRepository.readAllActivity();
    print(activities);
    emit(state.copyWith(isLoading: false, activities: activities));
  }
}
