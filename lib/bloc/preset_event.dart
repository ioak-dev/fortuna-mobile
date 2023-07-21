part of 'preset_bloc.dart';

abstract class PresetEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchPresets extends PresetEvent {}
