import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helper/date_function.dart';
import 'calender_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit({required DateTime focusedDate, DateTime? selectedDate})
      : super(CalendarState.initial(
            focusedDate: focusedDate, selectedDate: selectedDate)) {
    updateSelectedTab(selectedDate);
  }

  void updateSelectedDay(DateTime? selectedDay) {
    updateSelectedTab(selectedDay);
    emit(state.copyWith(selectedDay: selectedDay));
  }

  void updateFocusedDay(DateTime focusedDay) {
    emit(state.copyWith(focusedDay: focusedDay));
  }

  void previousMonth() {
    final newFocusedDay =
        DateTime(state.focusedDay.year, state.focusedDay.month - 1, 1);
    emit(state.copyWith(focusedDay: newFocusedDay));
  }

  void currentMonth() {
    final currentDate = DateTime.now();
    final newFocusedDay = DateTime(currentDate.year, currentDate.month, 1);
    emit(state.copyWith(focusedDay: newFocusedDay));
  }

  // Navigate to next month
  void nextMonth() {
    final newFocusedDay =
        DateTime(state.focusedDay.year, state.focusedDay.month + 1, 1);
    emit(state.copyWith(focusedDay: newFocusedDay));
  }

  void updateSelectedTab(DateTime? selectedDate) {
    String matchedLabel = "";
    if (selectedDate != null) {
      for (var option in QuickSelectionDate.quickSelectJoiningDateOptions) {
        DateTime optionDate = option["action"]();
        if (areSameDate(selectedDate, optionDate)) {
          matchedLabel = option["label"];
          break;
        }
      }
    }
    if (selectedDate == null) {
      matchedLabel = "No Date";
    }

    emit(state.copyWith(
        focusedDay: state.focusedDay,
        selectedDay: state.selectedDay,
        selectedTab: matchedLabel));
  }
}
