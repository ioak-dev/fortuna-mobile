part of 'activity_bloc.dart';

class ActivityState extends Equatable {
  const ActivityState({this.activities = const <Activity>[], this.isLoading = false});

  final List<Activity> activities;
  final bool isLoading;

  @override
  List<Object> get props => [activities, isLoading];

  ActivityState copyWith({
    List<Activity>? activities,
    bool? isLoading,
  }) {
    return ActivityState(
        activities: activities ?? this.activities,
        isLoading: isLoading ?? this.isLoading);
  }
}

class ActivityInitial extends ActivityState {
  @override
  List<Object> get props => [];
}
