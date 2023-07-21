import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:endurance/database/model/preset.dart';
import 'package:endurance/database/preset_repository.dart';
import 'package:equatable/equatable.dart';

part 'preset_event.dart';

part 'preset_state.dart';

class PresetBloc extends Bloc<PresetEvent, PresetState> {
  PresetBloc() : super(const PresetState()) {
    on<FetchPresets>(_mapFetchPresetsEventToState);
  }

  void _mapFetchPresetsEventToState(
      FetchPresets event, Emitter<PresetState> emit) async {
    print("fetching presets");
    emit(state.copyWith(isLoading: true));
    List<Preset> presets = await PresetRepository.readAllPreset();
    emit(state.copyWith(isLoading: false, presets: presets));
  }
}
