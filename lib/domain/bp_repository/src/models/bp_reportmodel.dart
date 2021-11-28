import 'package:mvp1/domain/bp_repository/src/models/bp_chartmodel.dart';
import 'package:mvp1/domain/reporting/enums/TimeRangeOfDay.dart';
import 'package:mvp1/domain/user_repository/src/models/user_model.dart';

import 'bp_model.dart';
import 'min_max_avg_bpreadings_model.dart';

class BpReport{
 late BpChartData bpChartData;
 late MinMaxAverageBpReading minMaxAverageBpReading;
 late List<Bp> readings; 
 late User user;
 late TimeRangeOfDay timeRangeOfDay;
}