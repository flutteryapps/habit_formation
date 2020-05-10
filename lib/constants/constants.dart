
enum DateType {
  PAST_DATE,
  FUTURE_DATE,
  TODAY,
}

enum HabitDayState {
  DONE,
  NOT_DONE,
  PENDING,
  NOT_APPLICABLE // future dates and dates before habit started
}