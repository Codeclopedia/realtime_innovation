enum Roles {
  productDesigner("Product Designer"),
  flutterDesigner("Flutter Developer"),
  qaTester("QA Tester"),
  productOwner("Product Owner");

  const Roles(this.value);
  final String value;
}

class Employee {
  int? id;
  String name;
  Roles employeeRole;
  DateTime joiningDate;
  DateTime? lastDate;

  Employee({
    this.id,
    required this.name,
    required this.employeeRole,
    required this.joiningDate,
    required this.lastDate,
  });

  factory Employee.fromJson({required Map<String, dynamic> jsonData}) {
    return Employee(
      id: jsonData["id"],
      name: jsonData["name"],
      employeeRole: Roles.values.firstWhere(
        (role) => role.value == jsonData["employeeRole"],
        orElse: () => Roles.productDesigner,
      ),
      joiningDate: DateTime.parse(jsonData["joiningDate"]),
      lastDate: jsonData["lastDate"] != null
          ? DateTime.parse(jsonData["lastDate"])
          : null,
    );
  }

  Employee copyWith({
    int? id,
    String? name,
    Roles? role,
    DateTime? joiningDate,
    DateTime? lastDate,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      employeeRole: role ?? employeeRole,
      joiningDate: joiningDate ?? this.joiningDate,
      lastDate: lastDate ?? this.lastDate,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "employeeRole": employeeRole.value,
        "joiningDate": joiningDate.toIso8601String(),
        "lastDate": lastDate?.toIso8601String(),
      };

  static Roles? getRoleFromString(String roleString) {
    return Roles.values.firstWhere(
      (role) => role.value == roleString,
      orElse: () => Roles.productDesigner,
    );
  }
}
