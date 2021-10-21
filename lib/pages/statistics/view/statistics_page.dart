import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mvp1/config/config.dart';
import 'package:mvp1/config/typography.dart';
import 'package:mvp1/domain/bp_repository/src/bp_repository.dart';
import 'package:mvp1/domain/bp_repository/src/models/models.dart';
import 'package:mvp1/domain/reporting/enums/TimeRangeOfDay.dart';
import 'package:mvp1/domain/reporting/enums/days.dart';
import 'package:mvp1/pages/analysis/widgets/noReadings.dart';
import 'package:mvp1/providers/userProvider.dart';
import 'package:mvp1/widgets/filters.dart';
import 'package:mvp1/widgets/safetext.dart';
import 'package:mvp1/widgets/userspecificappbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  DateTimeRange? dateRange;
  Days days = Days.All_time;
  TimeRangeOfDay dayTimeRange = TimeRangeOfDay.Any_Time_of_Day;

  void SetDaysAndDayTimeRange(
      Days selectedDays, TimeRangeOfDay selectedDayTimeRange) {
    setState(() {
      dayTimeRange = selectedDayTimeRange;
      days = selectedDays;
    });
  }

  void SetDateTimeRange(DateTimeRange? selecteddateRange) {
    setState(() {
      dateRange = selecteddateRange;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UserSpecificAppBar("Statistics", context),
      body: Column(
        children: [
          Filters(
              onDateRangeChanged: SetDateTimeRange,
              onDaysAndDayTimeOfDayChange: SetDaysAndDayTimeRange),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Consumer(builder: (context, watch, child) {
                  final selectedProfileId =
                      watch(selectedProfileProvider).state;

                  return ValueListenableBuilder<Box<Bp>>(
                    valueListenable: BpRepository.GetBox().listenable(),
                    builder: (context, box, _) {
                      final readings = box.values
                          .toList()
                          .cast<Bp>()
                          .where(
                              (element) => element.userId == selectedProfileId)
                          .toList();
                      if (readings.length == 0) {
                        return Text("No Readings Found", style: AppTypography.PrimaryText,);
                      }
                      var averageBp = BpRepository.GetAverageBp(
                          days, dayTimeRange, dateRange, readings);

                      // if (averageBp == null) {
                      //   return Column(
                      //     children: [
                      //       NoReadings(),
                      //     ],
                      //   );
                      // }

                      return !(readings.length==0 || averageBp==null)? Column(
                        children: [
                          Row(
                            children: [
                              BuildSafeText(
                                  "Average Blood Pressure (${averageBp.NumberOfDays} days)",
                                  AppTypography.SecondaryText),
                              // ("Average Blood Pressure (30 days)", textAlign: TextAlign.left,),
                            ],
                          ),
                          Row(
                            children: [
                              
                              Flexible(
                                flex: 3,
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    BuildSafeText(
                                        '${averageBp.AverageSystolic}/${averageBp.AverageDiastolic}',
                                        AppTypography.PrimaryHeadingThin),
                                    BuildSafeText(
                                        " mmHg", AppTypography.SecondaryText)
                                  ],
                                ),
                              ),
                              Flexible(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: Pallete.LightGreen,
                                      ),
                                      BuildSafeText(
                                          "  Normal", AppTypography.PrimaryText)
                                    ],
                                  ))
                            ],
                          ),
                          // Text(

                          //     "Avg Systolic - ${averageBp.AverageSystolic} \n  Avg Diastolic - ${averageBp.AverageDiastolic}  \n   Avg Pulse  - ${averageBp.AveragePulse}  \n    Avg Days  - ${averageBp.TotalReadings} "
                          //     ),
                        ],
                      ):Text("No Readings Found", style: AppTypography.PrimaryText,);
                    },
                  );
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
