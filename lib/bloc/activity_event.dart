part of 'activity_bloc.dart';

abstract class ActivityEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchActivities extends ActivityEvent {}
