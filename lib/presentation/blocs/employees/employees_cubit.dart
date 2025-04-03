import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_innovation/data/models/employee_model.dart';
import '../../../data/repositories/employee_repository.dart';
import 'employees_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  final EmployeeRepository employeeRepository;

  EmployeeCubit({required this.employeeRepository}) : super(EmployeeInitial()) {
    fetchEmployees();
  }

  void fetchEmployees() async {
    emit(EmployeeLoading());
    try {
      final employees = await employeeRepository.fetchEmployees();
      final currentEmployees = employees
          .where((e) =>
              e.lastDate == null ||
              e.lastDate != null && e.lastDate?.compareTo(DateTime.now()) == 1)
          .toList();
      final previousEmployees = employees
          .where((e) =>
              e.lastDate != null && e.lastDate?.compareTo(DateTime.now()) == -1)
          .toList();

      emit(EmployeeLoaded(
        currentEmployees: currentEmployees,
        previousEmployees: previousEmployees,
      ));
    } catch (e) {
      emit(EmployeeError(e.toString()));
    }
  }

  int get totalEmployeesCount {
    if (state is EmployeeLoaded) {
      final loadedState = state as EmployeeLoaded;
      return loadedState.currentEmployees.length +
          loadedState.previousEmployees.length;
    }
    return 0;
  }

  void addEmployee(Employee employee) async {
    try {
      final currentState = state;
      if (currentState is EmployeeLoaded) {
        final newEmployee = employee;

        await employeeRepository.addEmployee(newEmployee);
        fetchEmployees();
      }
    } catch (e) {
      emit(EmployeeError(e.toString()));
    }
  }

  void updateEmployee(Employee employee) async {
    try {
      await employeeRepository.updateEmployee(employee);
      fetchEmployees();
    } catch (e) {
      emit(EmployeeError(e.toString()));
    }
  }

  void deleteEmployee(int employeeId) async {
    try {
      await employeeRepository.deleteEmployee(employeeId);
      fetchEmployees();
    } catch (e) {
      emit(EmployeeError(e.toString()));
    }
  }
}
