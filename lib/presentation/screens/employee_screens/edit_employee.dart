import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realtime_innovation/data/models/employee_model.dart';
import '../../../core/helper/data_convert.dart';
import '../../blocs/employees/employee_data/employee_data_cubit.dart';
import '../../blocs/employees/employee_data/employee_data_state.dart';
import '../../blocs/employees/employees_cubit.dart';
import '../../widgets/button_custom_widget.dart';
import '../../widgets/custom_dropdown_widget.dart';
import '../../widgets/date_widgets.dart';
import '../../widgets/name_textfeild.dart';

class EditEmployeeDetailsScreen extends StatelessWidget {
  final Employee employee;
  const EditEmployeeDetailsScreen({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeFormCubit(employee),
      child: Scaffold(
        appBar: AppBar(
          leading: const SizedBox.shrink(),
          leadingWidth: 0,
          title: const Text('Edit Employee Details'),
          actions: [
            IconButton(
              onPressed: () {
                context.read<EmployeeCubit>().deleteEmployee(employee.id ?? -1);
                Navigator.pop(context);
              },
              icon: SvgPicture.asset("assets/svg/delete_icon.svg"),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<EmployeeFormCubit, EmployeeFormState>(
            builder: (context, state) {
              final employeeFormCubit = context.read<EmployeeFormCubit>();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextField(
                    Icons.person_outline,
                    'Employee name',
                    employeeFormCubit.nameController,
                  ),
                  const SizedBox(height: 16),
                  buildDropdownField(
                    context: context,
                    controller: employeeFormCubit.roleController,
                  ),
                  const SizedBox(height: 16),
                  buildDateSelector(
                    isEditScreen: true,
                    firstDate: state.firstDate,
                    firstDateCallback: (date) {
                      context.read<EmployeeFormCubit>().updateFirstDate(date);
                    },
                    lastDate: state.lastDate,
                    lastDateCallback: (date) {
                      context.read<EmployeeFormCubit>().updateLastDate(date);
                    },
                  ),
                  const Spacer(),
                  buildBottomActionButtons(
                    context: context,
                    onCancel: () {
                      Navigator.pop(context);
                    },
                    onSave: () {
                      final formState = context.read<EmployeeFormCubit>();
                      if (formState.nameController.text.isEmpty ||
                          formState.roleController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please fill all fields."),
                          ),
                        );
                        return;
                      }

                      final updatedEmployee = Employee(
                        id: employee.id,
                        name: formState.nameController.text,
                        employeeRole:
                            getRoleFromString(formState.roleController.text),
                        joiningDate: formState.state.firstDate,
                        lastDate: formState.state.lastDate,
                      );

                      context
                          .read<EmployeeCubit>()
                          .updateEmployee(updatedEmployee);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Employee updated!")),
                      );
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
