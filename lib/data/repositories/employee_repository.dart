import '../models/employee_model.dart';

abstract class EmployeeRepository {
  Future<void> addEmployee(Employee employee);
  Future<List<Employee>> fetchEmployees();
  Future<void> updateEmployee(Employee employee);
  Future<void> deleteEmployee(int id);
}
