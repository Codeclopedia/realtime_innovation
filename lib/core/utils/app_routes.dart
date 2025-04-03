import 'package:flutter/material.dart';
import 'package:realtime_innovation/data/models/employee_model.dart';
import 'package:realtime_innovation/presentation/screens/employee_screens/edit_employee.dart';
import 'package:realtime_innovation/presentation/screens/homepage.dart';

import '../../presentation/screens/employee_screens/add_employee.dart';

class AppRoutes {
  static const String addEmployee = '/add-employee';
  static const String editEmployee = '/edit-employee';
  static const String homepage = '/homepage';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homepage:
        return MaterialPageRoute(builder: (_) => const MyHomePage());
      case addEmployee:
        return MaterialPageRoute(
            builder: (_) => const AddEmployeeDetailsScreen());
      case editEmployee:
        return MaterialPageRoute(
            builder: (_) => EditEmployeeDetailsScreen(
                  employee: settings.arguments as Employee,
                ));
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
