import '../../data/models/employee_model.dart';

Roles getRoleFromString(String roleString) {
  return Roles.values.firstWhere(
    (role) => role.value == roleString,
    orElse: () => Roles.productDesigner,
  );
}
