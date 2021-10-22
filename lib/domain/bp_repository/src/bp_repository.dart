import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mvp1/Utility/Uid.dart';
import 'package:mvp1/Utility/dateTimeHelpers.dart';
import 'package:mvp1/config/config.dart';
import 'package:mvp1/domain/bp_repository/src/StandardBpUnits.dart';
import 'package:mvp1/domain/bp_repository/src/models/averagebp_model.dart';
import 'package:mvp1/domain/bp_repository/src/models/bp_info.dart';
import 'package:mvp1/domain/bp_repository/src/models/min_max_avg_bpreadings_model.dart';
import 'package:mvp1/domain/reporting/enums/TimeRangeOfDay.dart';
import 'package:mvp1/domain/reporting/enums/days.dart';
import 'package:mvp1/domain/reporting/enums/enumHelper.dart';
import 'package:mvp1/providers/Boxes.dart';

import 'enums/bp_status.dart';
import 'models/bp_model.dart';

class BpRepository {
  static Box<Bp> GetBox() {
    return Hive.box<Bp>(Boxes.BpreadingsBox);
  }

  static void add(Bp bp) {
    var bpBox = Hive.box<Bp>(Boxes.BpreadingsBox);
    bpBox.put(GetUID(), bp);
    bp.save();
  }

  static void Remove(String key) {
    var bpBox = Hive.box<Bp>(Boxes.BpreadingsBox);
    bpBox.delete(key);
  }

  static AverageBp? GetAverageBp(Days days, TimeRangeOfDay timeRangeOfDay,
      DateTimeRange? dateRange, List<Bp> readings) {
    if (days == Days.custom) {
      if (dateRange == null) {
        return null;
      }

      var filteredReadings = readings
          .map((e) {
            e.readingDateTime =
                DateTimeHelpers.convertToMidnightDate(e.readingDateTime);

            return e;
          })
          .toList()
          .where((element) =>
              (element.readingDateTime.isAfter(
                          DateTimeHelpers.convertToMidnightDate(
                              dateRange.start)) ||
                      DateTimeHelpers.convertToMidnightDate(dateRange.start)
                          .isAtSameMomentAs(element.readingDateTime)) &&
                  element.readingDateTime.isBefore(
                      DateTimeHelpers.convertToMidnightDate(dateRange.end)) ||
              DateTimeHelpers.convertToMidnightDate(dateRange.start)
                  .isAtSameMomentAs(element.readingDateTime));

      if (filteredReadings.length == 0) {
        return null;
      }

      var avgSystolic = filteredReadings
              .map((e) => e.systolic)
              .toList()
              .reduce((value, element) => value + element) /
          filteredReadings.length;
      var avglDiastolic = filteredReadings
              .map((e) => e.diastolic)
              .toList()
              .reduce((value, element) => value + element) /
          filteredReadings.length;
      var avgPulse = filteredReadings
              .map((e) => e.pulse)
              .toList()
              .reduce((value, element) => value + element) /
          filteredReadings.length;
      var averageBp = new AverageBp();
      averageBp.AverageSystolic = avgSystolic.toInt();
      averageBp.AverageDiastolic = avglDiastolic.toInt();
      averageBp.AveragePulse = avgPulse.toInt();
      averageBp.TotalReadings = filteredReadings.length;
      averageBp.NumberOfDays =
          DateTimeHelpers.GetDaysBetween(dateRange.start, dateRange.end);

      return averageBp;
    } else {
      var numberofDatesTillNow = DaysEnumHelper.GetNumberOfDays(days);
      var filteredReadings = <Bp>[];
      if (numberofDatesTillNow == null) {
        if (days == Days.All_time) {
          numberofDatesTillNow = readings
              .map((e) =>
                  DateTimeHelpers.convertToMidnightDate(e.readingDateTime))
              .toSet()
              .toList()
              .length;
          filteredReadings = readings;
        } else {
          return null;
        }
      } else {
        filteredReadings = readings
            .where((element) =>
                (DateTimeHelpers.convertToMidnightDate(element.readingDateTime)
                        .isAfter(DateTimeHelpers.convertToMidnightDate(
                                DateTime.now())
                            .subtract(Duration(days: numberofDatesTillNow!))) ||
                    DateTimeHelpers.convertToMidnightDate(DateTime.now())
                        .isAtSameMomentAs(element.readingDateTime)) &&
                (DateTimeHelpers.convertToMidnightDate(element.readingDateTime)
                        .isBefore(DateTime.now()) ||
                    DateTimeHelpers.convertToMidnightDate(DateTime.now())
                        .isAtSameMomentAs(element.readingDateTime)))
            .toList();
      }

      if (filteredReadings.length == 0) {
        return null;
      }

// Filter For The Time Range Of day

      if (timeRangeOfDay == TimeRangeOfDay.AM) {
        filteredReadings = filteredReadings
            .where((element) =>
                DateTimeHelpers.GetDatePeriod(element.readingDateTime) ==
                DayPeriod.am)
            .toList();
      } else if (timeRangeOfDay == TimeRangeOfDay.PM) {
        filteredReadings = filteredReadings
            .where((element) =>
                DateTimeHelpers.GetDatePeriod(element.readingDateTime) ==
                DayPeriod.pm)
            .toList();
      } else if (timeRangeOfDay == TimeRangeOfDay.Evening) {
        filteredReadings = filteredReadings
            .where((element) =>
                DateTimeHelpers.GetDayTimeRange(element.readingDateTime) ==
                TimeRangeOfDay.Evening)
            .toList();
      } else if (timeRangeOfDay == TimeRangeOfDay.Morning) {
        filteredReadings = filteredReadings
            .where((element) =>
                DateTimeHelpers.GetDayTimeRange(element.readingDateTime) ==
                TimeRangeOfDay.Morning)
            .toList();
      } else if (timeRangeOfDay == TimeRangeOfDay.Day) {
        filteredReadings = filteredReadings
            .where((element) =>
                DateTimeHelpers.GetDayTimeRange(element.readingDateTime) ==
                TimeRangeOfDay.Day)
            .toList();
      }
      if (filteredReadings.length == 0) {
        return null;
      }

      var avgSystolic = filteredReadings
              .map((e) => e.systolic)
              .toList()
              .reduce((value, element) => value + element) /
          filteredReadings.length;
      var avglDiastolic = filteredReadings
              .map((e) => e.diastolic)
              .toList()
              .reduce((value, element) => value + element) /
          filteredReadings.length;
      var avgPulse = filteredReadings
              .map((e) => e.pulse)
              .toList()
              .reduce((value, element) => value + element) /
          filteredReadings.length;

      var averageBp = new AverageBp();
      averageBp.AverageSystolic = avgSystolic.toInt();
      averageBp.AverageDiastolic = avglDiastolic.toInt();
      averageBp.AveragePulse = avgPulse.toInt();
      averageBp.TotalReadings = filteredReadings.length;
      averageBp.NumberOfDays = numberofDatesTillNow;
      return averageBp;
    }
  }

  static MinMaxAverageBpReading? getMinMaxAverageBpReadings(
      Days days,
      TimeRangeOfDay timeRangeOfDay,
      DateTimeRange? dateRange,
      List<Bp> readings) {
    if (days == Days.custom) {
      if (dateRange == null) {
        return null;
      }

      var filteredReadings = readings
          .map((e) {
            e.readingDateTime =
                DateTimeHelpers.convertToMidnightDate(e.readingDateTime);

            return e;
          })
          .toList()
          .where((element) =>
              (element.readingDateTime.isAfter(
                          DateTimeHelpers.convertToMidnightDate(
                              dateRange.start)) ||
                      DateTimeHelpers.convertToMidnightDate(dateRange.start)
                          .isAtSameMomentAs(element.readingDateTime)) &&
                  element.readingDateTime.isBefore(
                      DateTimeHelpers.convertToMidnightDate(dateRange.end)) ||
              DateTimeHelpers.convertToMidnightDate(dateRange.start)
                  .isAtSameMomentAs(element.readingDateTime));

      if (filteredReadings.length == 0) {
        return null;
      }

      var maxSystolic =
          filteredReadings.map((e) => e.systolic).toList().reduce(max);

      var minSystolic =
          filteredReadings.map((e) => e.systolic).toList().reduce(min);

      var avgSystolic = filteredReadings
              .map((e) => e.systolic)
              .toList()
              .reduce((value, element) => value + element) /
          filteredReadings.length;

      var minDiastolic =
          filteredReadings.map((e) => e.diastolic).toList().reduce((min));

      var maxDiastolic =
          filteredReadings.map((e) => e.diastolic).toList().reduce((max));

      var avglDiastolic = filteredReadings
              .map((e) => e.diastolic)
              .toList()
              .reduce((value, element) => value + element) /
          filteredReadings.length;

      var maxPulse =
          filteredReadings.map((e) => e.pulse).toList().reduce((max));

      var minPulse =
          filteredReadings.map((e) => e.pulse).toList().reduce((min));

      var avgPulse = filteredReadings
              .map((e) => e.pulse)
              .toList()
              .reduce((value, element) => value + element) /
          filteredReadings.length;

      var avgreading = new MinMaxAverageBpReading();

      avgreading.avgPulse = avgPulse.toInt();
      avgreading.minPulse = minPulse.toInt();
      avgreading.maxPulse = maxPulse.toInt();

      avgreading.avgSystolic = avgSystolic.toInt();
      avgreading.minSystolic = minSystolic.toInt();
      avgreading.maxSystolic = maxSystolic.toInt();

      avgreading.avgDiastolic = avglDiastolic.toInt();
      avgreading.minDiastolic = minDiastolic.toInt();
      avgreading.maxDiastolic = maxDiastolic.toInt();

      avgreading.numberofReadings =
          DateTimeHelpers.GetDaysBetween(dateRange.start, dateRange.end);
      avgreading.startDate = dateRange.start;
      avgreading.endDate = dateRange.end;

      return avgreading;
    } else {
      var numberofDatesTillNow = DaysEnumHelper.GetNumberOfDays(days);
      var filteredReadings = <Bp>[];
      if (numberofDatesTillNow == null) {
        if (days == Days.All_time) {
          numberofDatesTillNow = readings
              .map((e) =>
                  DateTimeHelpers.convertToMidnightDate(e.readingDateTime))
              .toSet()
              .toList()
              .length;
          filteredReadings = readings;
        } else {
          return null;
        }
      } else {
        filteredReadings = readings
            .where((element) =>
                (DateTimeHelpers.convertToMidnightDate(element.readingDateTime)
                        .isAfter(DateTimeHelpers.convertToMidnightDate(
                                DateTime.now())
                            .subtract(Duration(days: numberofDatesTillNow!))) ||
                    DateTimeHelpers.convertToMidnightDate(DateTime.now())
                        .isAtSameMomentAs(element.readingDateTime)) &&
                (DateTimeHelpers.convertToMidnightDate(element.readingDateTime)
                        .isBefore(DateTime.now()) ||
                    DateTimeHelpers.convertToMidnightDate(DateTime.now())
                        .isAtSameMomentAs(element.readingDateTime)))
            .toList();
      }

      if (filteredReadings.length == 0) {
        return null;
      }

// Filter For The Time Range Of day

      if (timeRangeOfDay == TimeRangeOfDay.AM) {
        filteredReadings = filteredReadings
            .where((element) =>
                DateTimeHelpers.GetDatePeriod(element.readingDateTime) ==
                DayPeriod.am)
            .toList();
      } else if (timeRangeOfDay == TimeRangeOfDay.PM) {
        filteredReadings = filteredReadings
            .where((element) =>
                DateTimeHelpers.GetDatePeriod(element.readingDateTime) ==
                DayPeriod.pm)
            .toList();
      } else if (timeRangeOfDay == TimeRangeOfDay.Evening) {
        filteredReadings = filteredReadings
            .where((element) =>
                DateTimeHelpers.GetDayTimeRange(element.readingDateTime) ==
                TimeRangeOfDay.Evening)
            .toList();
      } else if (timeRangeOfDay == TimeRangeOfDay.Morning) {
        filteredReadings = filteredReadings
            .where((element) =>
                DateTimeHelpers.GetDayTimeRange(element.readingDateTime) ==
                TimeRangeOfDay.Morning)
            .toList();
      } else if (timeRangeOfDay == TimeRangeOfDay.Day) {
        filteredReadings = filteredReadings
            .where((element) =>
                DateTimeHelpers.GetDayTimeRange(element.readingDateTime) ==
                TimeRangeOfDay.Day)
            .toList();
      }
      if (filteredReadings.length == 0) {
        return null;
      }

      var avgSystolic = filteredReadings
              .map((e) => e.systolic)
              .toList()
              .reduce((value, element) => value + element) /
          filteredReadings.length;
      var avglDiastolic = filteredReadings
              .map((e) => e.diastolic)
              .toList()
              .reduce((value, element) => value + element) /
          filteredReadings.length;
      var avgPulse = filteredReadings
              .map((e) => e.pulse)
              .toList()
              .reduce((value, element) => value + element) /
          filteredReadings.length;

      var maxSystolic =
          filteredReadings.map((e) => e.systolic).toList().reduce(max);

      var minSystolic =
          filteredReadings.map((e) => e.systolic).toList().reduce(min);

      var minDiastolic =
          filteredReadings.map((e) => e.diastolic).toList().reduce((min));

      var maxDiastolic =
          filteredReadings.map((e) => e.diastolic).toList().reduce((max));

      var maxPulse =
          filteredReadings.map((e) => e.pulse).toList().reduce((max));

      var minPulse =
          filteredReadings.map((e) => e.pulse).toList().reduce((min));

      var avgreading = new MinMaxAverageBpReading();

      avgreading.avgSystolic = avgSystolic.toInt();
      avgreading.avgDiastolic = avglDiastolic.toInt();
      avgreading.avgPulse = avgPulse.toInt();

      avgreading.maxSystolic = maxSystolic.toInt();
      avgreading.maxDiastolic = maxDiastolic.toInt();
      avgreading.maxPulse = maxPulse.toInt();

      avgreading.minSystolic = minSystolic.toInt();
      avgreading.minDiastolic = minDiastolic.toInt();
      avgreading.minPulse = minPulse.toInt();

avgreading.startDate=DateTime.now().subtract(Duration(days:numberofDatesTillNow));
avgreading.endDate=DateTime.now();
avgreading.numberofReadings= filteredReadings.length;


      return avgreading;
    }
  }

  static String GetBpStatusDisplayString(BpStatus bpStatus) {
    switch (bpStatus) {
      case BpStatus.LowPulse:
        return 'Low';
      case BpStatus.Normal_Pulse:
        return 'Normal';
      case BpStatus.HighPulse:
        return 'High';
      case BpStatus.Very_Low:
        return 'Very Low';
      case BpStatus.Low:
        return 'Low';
      case BpStatus.High:
        return 'High';
      case BpStatus.Very_High:
        return 'Very High';
      case BpStatus.Normal:
        return 'Normal';

      default:
        return "";
    }
  }

  static Color GetBpStatusColor(BpStatus bpStatus) {
    switch (bpStatus) {
      case BpStatus.LowPulse:
        return Pallete.LightRed;

      case BpStatus.Normal_Pulse:
        return Pallete.LightGreen;

      case BpStatus.HighPulse:
        return Pallete.DarkRed;

      case BpStatus.Very_Low:
        return Pallete.DarkRed;

      case BpStatus.Low:
        return Pallete.LightRed;

      case BpStatus.High:
        return Pallete.LightRed;

      case BpStatus.Very_High:
        return Pallete.DarkRed;

      case BpStatus.Normal:
        return Pallete.LightGreen;

      default:
        return Pallete.LightGreen;
    }
  }

  static Bp Get(String? id) {
    if (id == null) {
      var bp = new Bp();
      bp.systolic = 0;
      bp.diastolic = 0;
      bp.pulse = 0;
      bp.readingDateTime = DateTime.now();

      return bp;
    }
    var bp = new Bp();
    bp.systolic = 0;
    bp.diastolic = 0;
    bp.pulse = 0;
    bp.readingDateTime = DateTime.now();
    bp.note = "dsds";
    return bp;
  }

  static BpStatus GetPulseStatus(Bp bp) {
    if (_isHighPulse(bp)) {
      return BpStatus.HighPulse;
    } else if (_isLowPulse(bp)) {
      return BpStatus.LowPulse;
    } else {
      return BpStatus.Normal_Pulse;
    }
  }

static BpStatus GetBpStatusFromReadings(int systolic , int diastolic , int pulse){
var bp= new Bp();
bp.systolic=systolic;
bp.diastolic= diastolic;
bp.pulse= pulse;

var status= GetBpStatus(bp);
return status;

}
  static BpStatus GetBpStatus(Bp bp) {
    if (_isHighBp(bp)) {
      if (_isVeryHighBp(bp)) {
        return BpStatus.Very_High;
      }
      return BpStatus.High;
    } else if (_isLowBp(bp)) {
      if (_isVeryLowBp(bp)) {
        return BpStatus.Very_Low;
      }
      return BpStatus.Low;
    } else {
      return BpStatus.Normal;
    }
  }

  static bool _isHighBp(Bp bp) {
    var isHigh = bp.systolic > StandardBpReading.MaximumSystolic ||
        bp.diastolic > StandardBpReading.MaximumDiastolic ||
        bp.pulse > StandardBpReading.MaximumPulse;
    return isHigh;
  }

  static bool _isLowBp(Bp bp) {
    var isLow = bp.systolic < StandardBpReading.MinimumSystolic ||
        bp.diastolic < StandardBpReading.MinimumDiastolic ||
        bp.pulse < StandardBpReading.MinimumPulse;
    return isLow;
  }

  static bool _isVeryHighBp(Bp bp) {
    var isVeryLow = bp.systolic >= StandardBpReading.VeryHighSystolicMinima ||
        bp.diastolic >= StandardBpReading.VeryHighDiastolicMinima;
    return isVeryLow;
  }

  static bool _isVeryLowBp(Bp bp) {
    var isVeryHigh = bp.systolic <= StandardBpReading.VeryLowSystolicMaxima ||
        bp.diastolic <= StandardBpReading.VeryLowDiastolicMaxima;
    return isVeryHigh;
  }

  static bool _isHighPulse(Bp bp) {
    var isHighPulse = bp.pulse > StandardBpReading.MaxPulse;
    return isHighPulse;
  }

  static bool _isLowPulse(Bp bp) {
    var isLowPulse = bp.pulse < StandardBpReading.MinPulse;
    return isLowPulse;
  }

  static String _getPulseInfoMessage(BpStatus bpStatus) {
    String message = "Normal";
    if (bpStatus == BpStatus.HighPulse) {
      message = "High Pulse";
    }
    if (bpStatus == BpStatus.LowPulse) {
      message = "Low Pulse";
    }
    return message;
  }

  static String _getBpInfoMessage(BpStatus bpStatus) {
    String message = "";

    if (bpStatus == BpStatus.High) {
      message = "High Blood Pressure";
    }
    if (bpStatus == BpStatus.Low) {
      message = "Low Blood Pressure";
    }
    if (bpStatus == BpStatus.Very_High) {
      message = "Very High Blood Pressure";
    }
    if (bpStatus == BpStatus.Very_Low) {
      message = "Very Low Blood Pressure";
    }
    if (bpStatus == BpStatus.Normal) {
      message = "Normal";
    }

    return message;
  }

  static String _GetPulseSummary(BpStatus bpStatus) {
    String summary = "";

    if (bpStatus == BpStatus.HighPulse) {
      summary = "Your Pulse is High";
    } else if (bpStatus == BpStatus.LowPulse) {
      summary = "Your Pulse is Low ";
    } else {
      summary = "Your Pulse is Normal";
    }
    return summary;
  }

  static String _getBpInfoSummary(BpStatus bpStatus) {
    String summary = "";
    if (bpStatus == BpStatus.Very_High) {
      summary = "Your Blood Pressure is Very High ";
    } else if (bpStatus == BpStatus.Very_Low) {
      summary = "Your Blood Pressure is Very Low";
    } else if (bpStatus == BpStatus.High) {
      summary = "Your Blood Pressure is High";
    } else if (bpStatus == BpStatus.Low) {
      summary = "Your  Blood Pressure is Low";
    }

    if (bpStatus == BpStatus.Normal) {
      summary = "Your Bp is Normal";
    }

    return summary;
  }

  static BpInfo GetBpInfo(Bp bp) {
    var bpInfo = new BpInfo();
    var bpStatus = GetBpStatus(bp);
    var pulseStatus = GetPulseStatus(bp);

    var bpMessage = _getBpInfoMessage(bpStatus);
    var pulseMessage = _getPulseInfoMessage(bpStatus);

    bpInfo.message.add(bpMessage);
    bpInfo.message.add(pulseMessage);
    bpInfo.summary =
        _getBpInfoSummary(bpStatus) + " and " + _GetPulseSummary(pulseStatus);

    return bpInfo;
  }
}
