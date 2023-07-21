import 'package:equatable/equatable.dart';

const String tableActivity = 'activity';

class ActivityFields {
  static final List<String> values = [
    id,
    name,
    presetId,
    hour,
    minute,
    second,
    sortOrder,
    color,
    createdAt,
    modifiedAt
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String presetId = 'presetId';
  static const String hour = 'hour';
  static const String minute = 'minute';
  static const String second = 'second';
  static const String sortOrder = 'sortOrder';
  static const String color = 'color';
  static const String createdAt = 'createdAt';
  static const String modifiedAt = 'modifiedAt';
}

class Activity extends Equatable {
  final int? id;
  String name;
  final int presetId;
  int hour;
  int minute;
  int second;
  int sortOrder;
  int color;
  DateTime? createdAt;
  DateTime? modifiedAt;

  Activity(
      {this.id,
      required this.name,
      required this.presetId,
      required this.hour,
      required this.minute,
        required this.second,
      required this.sortOrder,
        required this.color,});

  Map<String, dynamic> toMap() {
    return {
      ActivityFields.id: id,
      ActivityFields.name: name,
      ActivityFields.presetId: presetId,
      ActivityFields.hour: hour,
      ActivityFields.minute: minute,
      ActivityFields.second: second,
      ActivityFields.sortOrder: sortOrder,
      ActivityFields.color: color,
      ActivityFields.createdAt: createdAt?.toIso8601String(),
      ActivityFields.modifiedAt: modifiedAt?.toIso8601String()
    };
  }

  static Activity fromMap(Map<String, dynamic> map) {
    Activity activity = Activity(
        id: map[ActivityFields.id] as int,
        name: map[ActivityFields.name] as String,
        presetId: map[ActivityFields.presetId] as int,
        hour: map[ActivityFields.hour] as int,
        minute: map[ActivityFields.minute] as int,
        second: map[ActivityFields.second] as int,
        sortOrder: map[ActivityFields.sortOrder] as int,
        color: map[ActivityFields.color] as int);

    activity.createdAt =
        DateTime.parse(map[ActivityFields.createdAt] as String);
    activity.modifiedAt =
        DateTime.parse(map[ActivityFields.modifiedAt] as String);

    return activity;
  }

  Activity copy(
      {int? id,
      String? name,
      int? presetId,
      int? hour,
      int? minute,
      int? second,
        int? sortOrder,
        int? color,
      DateTime? createdAt,
      DateTime? modifiedAt}) {
    Activity activity = Activity(
        id: id ?? this.id,
        name: name ?? this.name,
        presetId: presetId ?? this.presetId,
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        second: second ?? this.second,
        sortOrder: sortOrder ?? this.sortOrder,
        color: color ?? this.color);
    activity.createdAt = createdAt ?? this.createdAt;
    activity.modifiedAt = modifiedAt ?? this.modifiedAt;
    return activity;
  }

  @override
  String toString() {
    return 'Activity{id: $id, name: $name, presetId: $presetId, hour: $hour, minute: $minute, second: $second, sortOrder: $sortOrder, color: $color, createdAt: $createdAt, modifiedAt: $modifiedAt}';
  }

  @override
  List<Object> get props =>
      [id!, name, presetId, hour, minute, second, sortOrder, color];
}
