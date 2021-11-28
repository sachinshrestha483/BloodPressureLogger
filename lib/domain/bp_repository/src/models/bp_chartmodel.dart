import 'package:mvp1/domain/user_repository/src/models/user_model.dart';
import 'package:mvp1/domain/user_repository/user_repository.dart';
class BpChartData{
late int totalReadings;
late double normalReadingPercentage;
late double stage1HypertensionReadingPercentage;
late double stage2HypertensionReadingPercentage;
late double stage3HypertensionReadingPercentage;
late double HypotensionPercentage;
late int normalReadingCount;
late int stage1hypertensionReadingCount;
late int stage2hypertensionReadingCount;
late int stage3hypertensionReadingCount;
late int hypotensionReadingCount;
late  DateTime startDate;
late DateTime enddate;
late int numberOfDays;
late User user;
}