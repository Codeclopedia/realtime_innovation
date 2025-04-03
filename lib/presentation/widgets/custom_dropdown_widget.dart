import 'package:flutter/material.dart';
import 'package:realtime_innovation/core/utils/app_sizing.dart';

Widget buildDropdownField({
  required BuildContext context,
  required TextEditingController controller,
}) {
  return TextFormField(
    controller: controller,
    readOnly: true,
    style: TextStyle(fontSize: AppSizing.sp(15)),
    decoration: InputDecoration(
      hintText: "Select Role",
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizing.w(1))),
      prefixIcon: Icon(
        Icons.work_outline,
        size: AppSizing.h(2.5),
      ),
      suffixIcon: Icon(
        Icons.arrow_drop_down_rounded,
        size: AppSizing.h(5),
      ),
    ),
    onTap: () async {
      final selectedRole = await _showRoleSelectionSheet(context);
      if (selectedRole != null) {
        controller.text = selectedRole;
      }
    },
  );
}

Future<String?> _showRoleSelectionSheet(BuildContext context) async {
  List<String> roles = [
    "Product Designer",
    "Flutter Developer",
    "QA Tester",
    "Product Owner"
  ];

  return await showModalBottomSheet<String>(
    constraints: const BoxConstraints(minWidth: double.infinity),
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => const Divider(),
        itemCount: roles.length,
        itemBuilder: (context, index) {
          final role = roles[index];
          return ListTile(
            title: Center(child: Text(role)),
            onTap: () => Navigator.pop(context, role),
          );
        },
      );
    },
  );
}
