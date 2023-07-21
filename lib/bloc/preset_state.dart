part of 'preset_bloc.dart';

class PresetState extends Equatable {
  const PresetState({this.presets = const <Preset>[], this.isLoading = false});

  final List<Preset> presets;
  final bool isLoading;

  @override
  List<Object> get props => [presets, isLoading];

  PresetState copyWith({
    List<Preset>? presets,
    bool? isLoading,
  }) {
    return PresetState(
        presets: presets ?? this.presets,
        isLoading: isLoading ?? this.isLoading);
  }
}

class PresetInitial extends PresetState {
  @override
  List<Object> get props => [];
}
