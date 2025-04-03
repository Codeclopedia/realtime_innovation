import '../../core/services/local_storage_service.dart';
import '../models/employee_model.dart';
import 'employee_repository.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  EmployeeRepositoryImpl._();

  static final EmployeeRepositoryImpl _instance = EmployeeRepositoryImpl._();

  factory EmployeeRepositoryImpl() {
    return _instance;
  }

  @override
  Future<void> addEmployee(Employee employee) async {
    await LocalStorage.insertEmployee(employee);
  }

  @override
  Future<List<Employee>> fetchEmployees() async {
    return await LocalStorage.getEmployees();
  }

  @override
  Future<void> updateEmployee(Employee employee) async {
    await LocalStorage.updateEmployee(employee);
  }

  @override
  Future<void> deleteEmployee(int id) async {
    if (id == -1) return;
    await LocalStorage.deleteEmployee(id);
  }
}
