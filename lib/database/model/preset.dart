import 'package:equatable/equatable.dart';

const String tablePreset = 'preset';

class PresetFields {
  static final List<String> values = [id, name, createdAt, modifiedAt];

  static const String id = '_id';
  static const String name = 'name';
  static const String createdAt = 'createdAt';
  static const String modifiedAt = 'modifiedAt';
}

class Preset extends Equatable {
  final int? id;
  final String name;
  DateTime? createdAt;
  DateTime? modifiedAt;

  Preset({
    this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      PresetFields.id: id,
      PresetFields.name: name,
      PresetFields.createdAt: createdAt?.toIso8601String(),
      PresetFields.modifiedAt: modifiedAt?.toIso8601String()
    };
  }

  static Preset fromMap(Map<String, dynamic> map) {
    Preset preset = Preset(
        id: map[PresetFields.id] as int,
        name: map[PresetFields.name] as String);

    preset.createdAt = DateTime.parse(map[PresetFields.createdAt] as String);
    preset.modifiedAt = DateTime.parse(map[PresetFields.modifiedAt] as String);

    return preset;
  }

  Preset copy(
      {int? id, String? name, DateTime? createdAt, DateTime? modifiedAt}) {
    Preset preset = Preset(id: id ?? this.id, name: name ?? this.name);
    preset.createdAt = createdAt ?? this.createdAt;
    preset.modifiedAt = modifiedAt ?? this.modifiedAt;
    return preset;
  }

  @override
  String toString() {
    return 'Preset{id: $id, name: $name, createdAt: $createdAt, modifiedAt: $modifiedAt}';
  }

  @override
  List<Object> get props => [id!, name];
}
