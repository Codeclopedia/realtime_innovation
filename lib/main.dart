import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/utils/app_routes.dart';
import 'core/utils/app_sizing.dart';
import 'core/utils/theme_data.dart';
import 'data/repositories/employee_repository_impl.dart';
import 'presentation/blocs/employees/employees_cubit.dart';
import 'presentation/screens/homepage.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final employeeRepository = EmployeeRepositoryImpl();

  runApp(
    LayoutBuilder(
      builder: (context, constraints) {
        AppSizing.init(context);
        return BlocProvider(
          create: (context) =>
              EmployeeCubit(employeeRepository: employeeRepository),
          child: const MyApp(),
        );
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizing.init(context);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.appThemeData,
      navigatorKey: navigatorKey,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      home: const MyHomePage(),
    );
  }
}
