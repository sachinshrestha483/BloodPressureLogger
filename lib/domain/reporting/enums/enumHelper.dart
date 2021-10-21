import 'package:flutter/material.dart';
import 'package:mvp1/domain/reporting/enums/days.dart';
import 'package:mvp1/domain/reporting/enums/TimeRangeOfDay.dart';

class TimeRangeOfDayEnumHelper {
  static String GetDisPlayString(TimeRangeOfDay timeOfDay) {
    switch (timeOfDay) {
      case TimeRangeOfDay.AM:
        return "A.M.";
      case TimeRangeOfDay.PM:
        return "P.M.";
      case TimeRangeOfDay.Any_Time_of_Day:
        return "Any Time Of Day ";
      case TimeRangeOfDay.Day:
        return "Day (10:00 - 18:59)";
      case TimeRangeOfDay.Morning:
        return "Morning (04:00 - 09:59)";
      case TimeRangeOfDay.Evening:
        return "Evening (19:00 - 01:59)";
    }
  }
}

class DaysEnumHelper {
  static String GetDisPlayString(Days days) {
    switch (days) {
      case Days.All_time:
        return "All Time";
      case Days.custom:
        return "Custom";
      case Days.one_month:
        return "One Month";
      case Days.one_year:
        return "One Year";
      case Days.six_months:
        return "Six Months";
      case Days.three_months:
        return "Three Months";
    }
  }
}
