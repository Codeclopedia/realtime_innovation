import 'package:equatable/equatable.dart';

class EmployeeFormState extends Equatable {
  final String name;
  final String role;
  final DateTime firstDate;
  final DateTime? lastDate;

  EmployeeFormState({
    this.name = '',
    this.role = '',
    DateTime? firstDate,
    this.lastDate,
  }) : firstDate = firstDate ?? DateTime.now();

  EmployeeFormState copyWith({
    String? name,
    String? role,
    DateTime? firstDate,
    DateTime? lastDate,
  }) {
    return EmployeeFormState(
      name: name ?? this.name,
      role: role ?? this.role,
      firstDate: firstDate ?? this.firstDate,
      lastDate: lastDate,
    );
  }

  @override
  List<Object?> get props => [name, role, firstDate, lastDate];
}
