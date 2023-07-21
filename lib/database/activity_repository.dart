import 'package:endurance/database/database_provider.dart';
import 'package:endurance/database/model/activity.dart';

class ActivityRepository {

  static Future<Activity> create(Activity activity) async {
    final db = await DatabaseProvider.instance.database;
    if (activity.id == null) {
      activity.createdAt = DateTime.now();
    }
    activity.modifiedAt = DateTime.now();
    final id = await db.insert(tableActivity, activity.toMap());
    return activity.copy(id: id);
  }

  static Future<Activity> readActivity(int id) async {
    final db = await DatabaseProvider.instance.database;
    final response = await db.query(tableActivity,
        columns: ActivityFields.values,
        where: '${ActivityFields.id} = ?',
        whereArgs: [id]);
    if (response.isNotEmpty) {
      return Activity.fromMap(response.first);
    }
    throw Exception('ID ${id} not found');
  }

  static Future<List<Activity>> readAllActivity() async {
    final db = await DatabaseProvider.instance.database;
    const orderBy = '${ActivityFields.sortOrder} ASC';
    final response = await db.query(tableActivity, orderBy: orderBy);
    return response.map((map) => Activity.fromMap(map)).toList();
  }

  static Future<int> update(Activity activity) async {
    final db = await DatabaseProvider.instance.database;
    activity.modifiedAt = DateTime.now();
    return db.update(tableActivity, activity.toMap(),
        where: '${ActivityFields.id} = ?', whereArgs: [activity.id]);
  }

  static Future<int> delete(int id) async {
    final db = await DatabaseProvider.instance.database;
    return db
        .delete(tableActivity, where: '${ActivityFields.id} = ?', whereArgs: [id]);
  }
}
