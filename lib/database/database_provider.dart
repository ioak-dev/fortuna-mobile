import 'package:endurance/database/model/activity.dart';
import 'package:endurance/database/model/preset.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider instance = DatabaseProvider._init();
  static Database? _database;

  DatabaseProvider._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('endurance.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const boolType = 'BOOLEAN NOT NULL';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE ${tablePreset} (
        ${PresetFields.id} ${idType},
        ${PresetFields.name} ${textType},
        ${PresetFields.createdAt} ${textType},
        ${PresetFields.modifiedAt} ${textType}
       )
    ''');

    await db.execute('''
      CREATE TABLE ${tableActivity} (
        ${ActivityFields.id} ${idType},
        ${ActivityFields.name} ${textType},
        ${ActivityFields.presetId} ${integerType},
        ${ActivityFields.hour} ${integerType},
        ${ActivityFields.minute} ${integerType},
        ${ActivityFields.second} ${integerType},
        ${ActivityFields.sortOrder} ${integerType},
        ${ActivityFields.color} ${integerType},
        ${ActivityFields.createdAt} ${textType},
        ${ActivityFields.modifiedAt} ${textType}
       )
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
