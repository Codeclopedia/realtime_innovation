import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:realtime_innovation/core/utils/app_colors.dart';
import 'package:realtime_innovation/core/utils/app_sizing.dart';

import '../../core/utils/app_routes.dart';
import '../../data/models/employee_model.dart';
import '../blocs/employees/employees_cubit.dart';
import '../blocs/employees/employees_state.dart';
import '../widgets/error_widget.dart';
import '../widgets/no_employee_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee List"),
      ),
      body: BlocBuilder<EmployeeCubit, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeLoaded) {
            final currentEmployees = state.currentEmployees;
            final previousEmployees = state.previousEmployees;

            if (currentEmployees.isEmpty && previousEmployees.isEmpty) {
              return noEmployeeWidget();
            }
            return Stack(
              children: [
                ListView(
                  children: [
                    _buildSectionTitle("Current employees"),
                    _buildEmployeeList(
                        context: context,
                        employees: currentEmployees,
                        currentlyWorking: true),
                    SizedBox(height: AppSizing.h(0.5)),
                    _buildSectionTitle("Previous employees"),
                    _buildEmployeeList(
                        context: context,
                        employees: previousEmployees,
                        currentlyWorking: false),
                    SizedBox(
                      height: AppSizing.h(5),
                    )
                  ],
                ),
                swipeLeftHint()
              ],
            );
          }
          if (state is EmployeeError) {
            return errorWidget(message: state.message);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addEmployee);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget swipeLeftHint() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        alignment: Alignment.centerLeft,
        width: double.infinity,
        height: AppSizing.h(7),
        padding: EdgeInsets.symmetric(
            vertical: AppSizing.h(1), horizontal: AppSizing.w(3)),
        decoration: const BoxDecoration(color: AppColors.unhighlightColor),
        child: const Text(
          "Swipe left to delete",
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: AppSizing.h(1.5), horizontal: AppSizing.w(4)),
      color: AppColors.unhighlightColor,
      child: Text(title,
          style: TextStyle(
              color: AppColors.swatchColor,
              fontSize: AppSizing.sp(16),
              fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildEmployeeList(
      {required BuildContext context,
      required List<Employee> employees,
      required bool currentlyWorking}) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final Employee employee = employees[index];
          return _buildSlidableTile(
              context: context,
              employee: employee,
              currentlyWorking: currentlyWorking);
        },
        separatorBuilder: (context, index) {
          return Divider(
            thickness: AppSizing.h(0.03),
          );
        },
        itemCount: employees.length);
  }

  Widget _buildSlidableTile(
      {required BuildContext context,
      required Employee employee,
      required bool currentlyWorking}) {
    return Slidable(
      key: ValueKey(employee.id),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (_) =>
                context.read<EmployeeCubit>().deleteEmployee(employee.id ?? -1),
            backgroundColor: AppColors.deleteSlidableBackgroundColor,
            foregroundColor: AppColors.deleteSlidableForegroundColor,
            icon: Icons.delete,
            label: "Delete",
          ),
        ],
      ),
      child: ListTile(
        onTap: currentlyWorking
            ? () {
                Navigator.pushNamed(context, AppRoutes.editEmployee,
                    arguments: employee);
              }
            : null,
        title: Text(employee.name,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(employee.employeeRole.value),
            Text(
              currentlyWorking
                  ? "From ${DateFormat("dd MMM, yyyy").format(employee.joiningDate)}  ${employee.lastDate != null ? "- ${DateFormat("dd MMM, yyyy").format(employee.lastDate ?? DateTime.now())}" : ""}"
                  : "${DateFormat("dd MMM, yyyy").format(employee.joiningDate)} - ${DateFormat("dd MMM, yyyy").format(employee.lastDate ?? DateTime.now())}",
              style: TextStyle(
                  color: AppColors.hintTextColor, fontSize: AppSizing.sp(12)),
            ),
          ],
        ),
      ),
    );
  }
}
