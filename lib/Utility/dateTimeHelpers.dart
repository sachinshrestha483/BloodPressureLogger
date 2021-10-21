import 'package:flutter/material.dart';
import 'package:mvp1/domain/reporting/enums/TimeRangeOfDay.dart';

class DateTimeHelpers{

static int GetDaysBetween(DateTime from , DateTime to){
from = DateTime(from.year, from.month, from.day);
     to = DateTime(to.year, to.month, to.day);
   return (to.difference(from).inHours / 24).round();
}

static DateTime convertToMidnightDate(DateTime date){

var midnightDate = date.subtract(Duration(
      minutes: date.minute,
      hours: date.hour,
      seconds: date.second,
      milliseconds: date.millisecond,
      microseconds: date.microsecond));

return midnightDate;
}

static DayPeriod GetDatePeriod(DateTime date){
  if(date.hour<=12){
      return DayPeriod.am; 
    }
  return  DayPeriod.pm;
}

static TimeRangeOfDay GetDayTimeRange(DateTime date){
  if(date.hour>=4 && date.hour<=9){
return TimeRangeOfDay.Morning;
  }
  if(date.hour>=10&& date.hour<=18){
return TimeRangeOfDay.Day;
  }
  if(date.hour>=19&& date.hour<=3){
return TimeRangeOfDay.Evening;
  }
return TimeRangeOfDay.Evening;

}




}