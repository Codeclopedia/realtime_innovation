import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/employee_model.dart';
import 'employee_data_state.dart';

class EmployeeFormCubit extends Cubit<EmployeeFormState> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  EmployeeFormCubit(Employee? employee)
      : super(EmployeeFormState(
            firstDate: employee?.joiningDate, lastDate: employee?.lastDate)) {
    nameController.text = employee?.name ?? '';
    roleController.text = employee?.employeeRole.value ?? '';
  }

  void updateName(String name) {
    emit(state.copyWith(name: name));
  }

  void updateRole(String role) {
    emit(state.copyWith(role: role));
  }

  void updateFirstDate(DateTime? date) {
    emit(state.copyWith(firstDate: date));
  }

  void updateLastDate(DateTime? date) {
    emit(state.copyWith(lastDate: date));
  }

  void resetForm() {
    emit(EmployeeFormState());
  }

  @override
  Future<void> close() {
    nameController.dispose();
    roleController.dispose();
    return super.close();
  }
}
