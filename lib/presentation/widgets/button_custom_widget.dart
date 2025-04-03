import 'package:flutter/material.dart';
import 'package:realtime_innovation/core/utils/app_colors.dart';
import 'package:realtime_innovation/core/utils/app_sizing.dart';

import '../../core/utils/app_routes.dart';

Widget buildBottomActionButtons(
    {required BuildContext context,
    required Function() onCancel,
    required Function() onSave}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      ElevatedButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.homepage,
            (route) => false,
          );
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.unselectedButtonBackgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizing.w(1)))),
        child: const Text(
          'Cancel',
          style: TextStyle(color: AppColors.unselectedbuttonTextColor),
        ),
      ),
      const SizedBox(width: 8),
      ElevatedButton(
        onPressed: onSave,
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonBackgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizing.w(1)))),
        child: const Text(
          'Save',
          style: TextStyle(color: AppColors.buttonTextColor),
        ),
      ),
    ],
  );
}
