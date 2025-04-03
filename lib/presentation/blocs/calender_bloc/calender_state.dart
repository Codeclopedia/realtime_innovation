import 'package:equatable/equatable.dart';

class CalendarState extends Equatable {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final String? selectedTab;

  const CalendarState({
    required this.focusedDay,
    this.selectedDay,
    this.selectedTab,
  });

  factory CalendarState.initial({
    required DateTime focusedDate,
    DateTime? selectedDate,
  }) {
    return CalendarState(
      focusedDay: focusedDate,
      selectedDay: selectedDate,
    );
  }

  CalendarState copyWith({
    DateTime? focusedDay,
    DateTime? selectedDay,
    String? selectedTab,
    bool resetFocusedDay = false,
    bool resetSelectedDay = false,
  }) {
    return CalendarState(
      focusedDay:
          resetFocusedDay ? DateTime.now() : (focusedDay ?? this.focusedDay),
      selectedDay: resetSelectedDay ? null : selectedDay,
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }

  @override
  List<Object?> get props => [focusedDay, selectedDay, selectedTab];
}
