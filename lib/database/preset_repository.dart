import 'package:endurance/database/database_provider.dart';
import 'package:endurance/database/model/preset.dart';

class PresetRepository {

  static Future<Preset> create(Preset preset) async {
    final db = await DatabaseProvider.instance.database;
    if (preset.id == null) {
      preset.createdAt = DateTime.now();
    }
    preset.modifiedAt = DateTime.now();
    final id = await db.insert(tablePreset, preset.toMap());
    return preset.copy(id: id);
  }

  static Future<Preset> readPreset(int id) async {
    final db = await DatabaseProvider.instance.database;
    final response = await db.query(tablePreset,
        columns: PresetFields.values,
        where: '${PresetFields.id} = ?',
        whereArgs: [id]);
    if (response.isNotEmpty) {
      return Preset.fromMap(response.first);
    }
    throw Exception('ID ${id} not found');
  }

  static Future<List<Preset>> readAllPreset() async {
    final db = await DatabaseProvider.instance.database;
    const orderBy = '${PresetFields.name} ASC';
    final response = await db.query(tablePreset, orderBy: orderBy);
    return response.map((map) => Preset.fromMap(map)).toList();
  }

  static Future<int> update(Preset preset) async {
    final db = await DatabaseProvider.instance.database;
    preset.modifiedAt = DateTime.now();
    return db.update(tablePreset, preset.toMap(),
        where: '${PresetFields.id} = ?', whereArgs: [preset.id]);
  }

  static Future<int> delete(int id) async {
    final db = await DatabaseProvider.instance.database;
    return db
        .delete(tablePreset, where: '${PresetFields.id} = ?', whereArgs: [id]);
  }
}
