import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../core/helper/date_function.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_sizing.dart';
import 'custom_datepicker_widget.dart';

Widget buildDateSelector({
  DateTime? firstDate,
  DateTime? lastDate,
  bool? isEditScreen,
  required Function(DateTime?) firstDateCallback,
  required Function(DateTime?) lastDateCallback,
}) {
  return Row(
    children: [
      Expanded(
        child: _buildDateButton(
          text: firstDate == null || isToday(firstDate)
              ? 'Today'
              : DateFormat("dd MMM yyyy").format(firstDate),
          initialDatetime: firstDate,
          selectedDateCallback: (p0) => firstDateCallback(p0),
          isEnabled: true,
        ),
      ),
      const Icon(Icons.arrow_right_alt, color: AppColors.iconPrimaryColor),
      Expanded(
        child: _buildDateButton(
            text: lastDate == null
                ? 'No Date'
                : DateFormat("dd MMM yyyy").format(lastDate),
            isLastDate: true,
            initialDatetime: lastDate,
            joiningDate: firstDate,
            selectedDateCallback: lastDateCallback,
            isEnabled: isEditScreen ?? false),
      ),
    ],
  );
}

Widget _buildDateButton(
    {required String text,
    DateTime? initialDatetime,
    DateTime? joiningDate,
    bool? isLastDate,
    required Function(DateTime?) selectedDateCallback,
    required bool isEnabled}) {
  return dateOutlinedButton(
    text: text,
    iconPath: "assets/svg/calendar_icon.svg",
    isEnabled: isEnabled,
    onPressed: () {
      showCustomDatePicker(
        isLastDate: isLastDate ?? false,
        joiningDate: joiningDate,
        initialDate: initialDatetime,
        onDateSelected: (selectedDate) => selectedDateCallback(selectedDate),
      );
    },
  );
}

Widget dateOutlinedButton({
  required String text,
  required String iconPath,
  required VoidCallback? onPressed,
  bool isEnabled = true,
}) {
  return InkWell(
    onTap: isEnabled ? onPressed : null,
    borderRadius: BorderRadius.circular(5),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: AppSizing.h(1.5)),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(5),
        color:
            isEnabled ? Colors.transparent : AppColors.secondaryBackgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconPath,
            height: AppSizing.h(2.5),
          ),
          const SizedBox(width: 15),
          Text(
            text,
            style: TextStyle(
              color: isEnabled
                  ? AppColors.primarytextColor
                  : AppColors.hintTextColor,
            ),
          ),
        ],
      ),
    ),
  );
}
