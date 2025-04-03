import 'package:equatable/equatable.dart';

import '../../../data/models/employee_model.dart';

abstract class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object?> get props => [];
}

class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {
  final List<Employee> currentEmployees;
  final List<Employee> previousEmployees;

  const EmployeeLoaded({
    required this.currentEmployees,
    required this.previousEmployees,
  });

  @override
  List<Object?> get props => [currentEmployees, previousEmployees];
}

class EmployeeError extends EmployeeState {
  final String message;

  const EmployeeError(this.message);

  @override
  List<Object?> get props => [message];
}
