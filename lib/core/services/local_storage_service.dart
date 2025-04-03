import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../data/models/employee_model.dart';

class LocalStorage {
  static Database? _database;

  static Future<Database> _getDatabase() async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'employee_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE employees(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT,
              employeeRole TEXT,
              joiningDate TEXT,
              lastDate TEXT
          )''',
        );
      },
    );
  }

  static Future<int> insertEmployee(Employee employee) async {
    final db = await _getDatabase();
    return await db.insert('employees', employee.toJson());
  }

  static Future<List<Employee>> getEmployees() async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('employees');

    return List.generate(
        maps.length, (i) => Employee.fromJson(jsonData: maps[i]));
  }

  static Future<int> updateEmployee(Employee employee) async {
    final db = await _getDatabase();
    return await db.update(
      'employees',
      employee.toJson(),
      where: "id = ?",
      whereArgs: [employee.id],
    );
  }

  static Future<int> deleteEmployee(int id) async {
    final db = await _getDatabase();
    return await db.delete('employees', where: "id = ?", whereArgs: [id]);
  }
}
