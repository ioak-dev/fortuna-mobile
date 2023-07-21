import 'package:endurance/bloc/preset_bloc.dart';
import 'package:endurance/database/database_provider.dart';
import 'package:endurance/preset/preset_list/preset_list_item.dart';
import 'package:endurance/database/model/preset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PresetList extends StatefulWidget {
  const PresetList({Key? key}) : super(key: key);

  @override
  State<PresetList> createState() => _PresetListState();
}

class _PresetListState extends State<PresetList> {
  List<Preset> presets = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshPresets();
  }

  void refreshPresets() async {
    final presetBloc = BlocProvider.of<PresetBloc>(context);
    presetBloc.add(FetchPresets());
    // setState(() => isLoading = true);
    // presets = await DatabaseProvider.instance.readAllPreset();
    // setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PresetBloc, PresetState>(builder: (context, state) {
      return Expanded(
          child: ListView.builder(
        itemCount: state.presets.length,
        itemBuilder: (context, index) {
          return PresetListItem(preset: state.presets[index]);
        },
      ));
    });
  }
}
