import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helper/data_convert.dart';
import '../../../core/utils/app_sizing.dart';
import '../../../data/models/employee_model.dart';
import '../../blocs/employees/employee_data/employee_data_cubit.dart';
import '../../blocs/employees/employee_data/employee_data_state.dart';
import '../../blocs/employees/employees_cubit.dart';
import '../../widgets/button_custom_widget.dart';
import '../../widgets/custom_dropdown_widget.dart';
import '../../widgets/date_widgets.dart';
import '../../widgets/name_textfeild.dart';

class AddEmployeeDetailsScreen extends StatelessWidget {
  const AddEmployeeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        leadingWidth: 0,
        title: const Text('Add Employee Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocProvider(
          create: (context) => EmployeeFormCubit(null),
          child: BlocBuilder<EmployeeFormCubit, EmployeeFormState>(
              builder: (context, state) {
            final employeeFormCubit = context.read<EmployeeFormCubit>();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<EmployeeFormCubit, EmployeeFormState>(
                  builder: (context, state) {
                    return buildTextField(
                      Icons.person_outline,
                      'Employee name',
                      employeeFormCubit.nameController,
                    );
                  },
                ),
                const SizedBox(height: 16),
                BlocBuilder<EmployeeFormCubit, EmployeeFormState>(
                  builder: (context, state) {
                    return buildDropdownField(
                      context: context,
                      controller: employeeFormCubit.roleController,
                    );
                  },
                ),
                const SizedBox(height: 16),
                BlocBuilder<EmployeeFormCubit, EmployeeFormState>(
                  builder: (context, state) {
                    return buildDateSelector(
                      firstDate: state.firstDate,
                      firstDateCallback: (date) {
                        context.read<EmployeeFormCubit>().updateFirstDate(date);
                      },
                      lastDate: state.lastDate,
                      lastDateCallback: (date) {
                        // context.read<EmployeeFormCubit>().updateLastDate(date);
                      },
                    );
                  },
                ),
                const Spacer(),
                Divider(
                  thickness: AppSizing.h(0.05),
                ),
                BlocBuilder<EmployeeFormCubit, EmployeeFormState>(
                  builder: (context, state) {
                    return buildBottomActionButtons(
                      context: context,
                      onCancel: () {
                        context.read<EmployeeFormCubit>().resetForm();
                      },
                      onSave: () {
                        final formState = context.read<EmployeeFormCubit>();

                        if (formState.nameController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Please enter the employee's name")),
                          );
                          return;
                        }

                        if (formState.roleController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Please select a role")),
                          );
                          return;
                        }

                        final newEmployee = Employee(
                          name: formState.nameController.text,
                          employeeRole:
                              getRoleFromString(formState.roleController.text),
                          joiningDate: formState.state.firstDate,
                          lastDate: formState.state.lastDate,
                        );

                        context.read<EmployeeCubit>().addEmployee(newEmployee);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Employee added successfully!")),
                        );

                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
