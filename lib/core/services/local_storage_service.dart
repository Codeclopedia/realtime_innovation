import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/employee_model.dart';

class LocalStorage {
  static const String _employeeKey = "employees";

  static Future<int> insertEmployee(Employee employee) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> employees = prefs.getStringList(_employeeKey) ?? [];

    int newId = employees.length + 1;
    Employee newEmployee = employee.copyWith(id: newId);

    employees.add(jsonEncode(newEmployee.toJson()));
    await prefs.setStringList(_employeeKey, employees);

    return newId;
  }

  static Future<List<Employee>> getEmployees() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> employees = prefs.getStringList(_employeeKey) ?? [];

    return employees
        .map((e) => Employee.fromJson(jsonData: jsonDecode(e)))
        .toList();
  }

  static Future<int> updateEmployee(Employee employee) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> employees = prefs.getStringList(_employeeKey) ?? [];

    List<Map<String, dynamic>> employeeList =
        employees.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();

    for (int i = 0; i < employeeList.length; i++) {
      if (employeeList[i]["id"] == employee.id) {
        employeeList[i] = employee.toJson();

        List<String> updatedEmployees =
            employeeList.map((e) => jsonEncode(e)).toList();

        await prefs.setStringList(_employeeKey, updatedEmployees);
        return 1;
      }
    }
    return 0;
  }

  static Future<int> deleteEmployee(int id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> employees = prefs.getStringList(_employeeKey) ?? [];

    List<String> updatedEmployees = employees
        .where((e) => (jsonDecode(e) as Map<String, dynamic>)["id"] != id)
        .toList();

    if (updatedEmployees.length == employees.length) {
      return 0;
    }

    await prefs.setStringList(_employeeKey, updatedEmployees);
    return 1;
  }
}
