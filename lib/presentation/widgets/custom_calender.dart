import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_innovation/core/utils/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/helper/date_function.dart';
import '../../core/utils/app_sizing.dart';
import '../blocs/calender_bloc/calender_cubit.dart';
import '../blocs/calender_bloc/calender_state.dart';

Widget calendarScreen(bool isLastDate, DateTime? joiningDate) {
  String monthName(int month) {
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return monthNames[month - 1];
  }

  return Center(
    child: BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        final calendarCubit = context.read<CalendarCubit>();
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.arrow_left_rounded,
                      color: isLastDate
                          ? isSameMonth(state.focusedDay, joiningDate!)
                              ? AppColors.iconUnhighlightColor
                              : AppColors.iconSecondaryColor
                          : AppColors.iconSecondaryColor,
                      size: AppSizing.sp(40)),
                  onPressed: isLastDate
                      ? isSameMonth(state.focusedDay, joiningDate!)
                          ? null
                          : () => calendarCubit.previousMonth()
                      : () => calendarCubit.previousMonth(),
                ),
                Text(
                  "${monthName(state.focusedDay.month)} ${state.focusedDay.year}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.arrow_right_rounded,
                      color: AppColors.iconSecondaryColor,
                      size: AppSizing.sp(40)),
                  onPressed: () => calendarCubit.nextMonth(),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  child: TableCalendar(
                    rowHeight: 35,
                    daysOfWeekHeight: AppSizing.h(5),
                    focusedDay: state.focusedDay,
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    calendarFormat: CalendarFormat.month,
                    shouldFillViewport: false,
                    daysOfWeekVisible: true,
                    availableGestures: AvailableGestures.none,
                    headerVisible: false,
                    calendarStyle: const CalendarStyle(
                      tablePadding: EdgeInsets.zero,
                      markerSize: 20,
                      todayDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      defaultTextStyle:
                          TextStyle(color: AppColors.primarytextColor),
                      weekendTextStyle:
                          TextStyle(color: AppColors.primarytextColor),
                      todayTextStyle:
                          TextStyle(color: AppColors.highlighttextColor),
                      outsideDaysVisible: false,
                      disabledTextStyle:
                          TextStyle(color: AppColors.hintTextColor),
                    ),
                    calendarBuilders: CalendarBuilders(
                      selectedBuilder: (context, date, _) {
                        double indicatorSize =
                            AppSizing.h(6); // Adjust this value as needed
                        return Center(
                          child: Container(
                            width: indicatorSize,
                            height: indicatorSize,
                            decoration: const BoxDecoration(
                              color: AppColors
                                  .highlighttextColor, // Your desired color
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${date.day}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13, // Adjust text size as needed
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    enabledDayPredicate: isLastDate
                        ? (day) {
                            return day.isAfter(DateTime(
                              joiningDate?.year ?? 0,
                              joiningDate?.month ?? 0,
                              joiningDate?.day ?? 0,
                            ));
                          }
                        : null,
                    selectedDayPredicate: (day) {
                      return isSameDay(state.selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      context
                          .read<CalendarCubit>()
                          .updateSelectedDay(selectedDay);
                    },
                  ),
                )),
          ],
        );
      },
    ),
  );
}
