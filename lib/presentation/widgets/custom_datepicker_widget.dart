import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../core/helper/date_function.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_sizing.dart';
import '../../main.dart';
import '../blocs/calender_bloc/calender_cubit.dart';
import '../blocs/calender_bloc/calender_state.dart';
import 'custom_calender.dart';

Future<void> showCustomDatePicker(
    {required bool isLastDate,
    DateTime? joiningDate,
    DateTime? initialDate,
    required Function(DateTime?) onDateSelected}) async {
  await showDialog(
    context: navigatorKey.currentContext!,
    barrierDismissible: true,
    builder: (context) {
      return BlocProvider(
        create: (_) => CalendarCubit(
          focusedDate: initialDate ?? joiningDate ?? DateTime.now(),
          selectedDate: initialDate,
        ),
        child: BlocBuilder<CalendarCubit, CalendarState>(
          builder: (context, state) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizing.w(3)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: AppSizing.h(1)),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSizing.w(3), vertical: AppSizing.h(1)),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: isLastDate
                        ? QuickSelectionDate
                            .quickSelectionLastDateOptions.length
                        : QuickSelectionDate
                            .quickSelectJoiningDateOptions.length,
                    itemBuilder: (context, index) {
                      final currentQuickSelectionList = isLastDate
                          ? QuickSelectionDate.quickSelectionLastDateOptions
                          : QuickSelectionDate.quickSelectJoiningDateOptions;
                      return _quickSelectButton(
                          text: currentQuickSelectionList[index]["label"],
                          onTap: () {
                            final cubit = context.read<CalendarCubit>();
                            final label =
                                currentQuickSelectionList[index]["label"];
                            final DateTime? actionDate =
                                currentQuickSelectionList[index]["action"]();

                            final isDifferentMonth =
                                state.focusedDay.month != actionDate?.month ||
                                    state.focusedDay.year != actionDate?.year;

                            if (isDifferentMonth && label != "No Date") {
                              cubit.currentMonth();
                            }

                            if (isLastDate) {
                              if (label == "No Date") {
                                cubit.updateSelectedDay(null);
                              } else if (label == "Today" &&
                                  actionDate != null) {
                                if (!isAfter(joiningDate!, actionDate)) {
                                  cubit.updateSelectedDay(actionDate);
                                }
                              }
                              return;
                            }

                            cubit.updateSelectedDay(actionDate);
                          },
                          isSelected: state.selectedTab ==
                              currentQuickSelectionList[index]["label"]);
                    },
                  ),
                  calendarScreen(isLastDate, joiningDate),
                  SizedBox(height: AppSizing.h(2)),
                  Divider(
                    thickness: AppSizing.h(0.05),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: AppSizing.w(3),
                        right: AppSizing.w(3),
                        bottom: AppSizing.h(1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset("assets/svg/calendar_icon.svg"),
                            SizedBox(width: AppSizing.w(2)),
                            Text(
                              state.selectedDay == null
                                  ? "No Date"
                                  : DateFormat("d MMM yyyy")
                                      .format(state.selectedDay!),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _actionButton(
                                text: "Cancel",
                                isAcceptButton: false,
                                onTap: () {
                                  Navigator.pop(context);
                                }),
                            SizedBox(width: AppSizing.w(2)),
                            _actionButton(
                              text: "Save",
                              isAcceptButton: true,
                              onTap: () {
                                onDateSelected(state.selectedDay);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

Widget _quickSelectButton(
    {required String text,
    required VoidCallback onTap,
    required bool isSelected}) {
  return ElevatedButton(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
        textStyle: TextStyle(fontSize: AppSizing.sp(12)),
        backgroundColor: isSelected
            ? AppColors.buttonBackgroundColor
            : AppColors.unselectedButtonBackgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizing.w(1.5)))),
    child: Text(
      text,
      style: TextStyle(
          color: isSelected
              ? AppColors.buttonTextColor
              : AppColors.unselectedbuttonTextColor),
    ),
  );
}

Widget _actionButton(
    {required String text, bool? isAcceptButton, required VoidCallback onTap}) {
  return TextButton(
    onPressed: onTap,
    style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizing.w(1.5))),
        backgroundColor: isAcceptButton ?? false
            ? AppColors.buttonBackgroundColor
            : AppColors.unselectedButtonBackgroundColor),
    child: Text(
      text,
      style: TextStyle(
          color: isAcceptButton ?? false
              ? AppColors.buttonTextColor
              : AppColors.unselectedbuttonTextColor),
    ),
  );
}
