import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:mvp1/config/typography.dart';
import 'package:mvp1/domain/bp_repository/src/bp_repository.dart';
import 'package:mvp1/domain/bp_repository/src/models/models.dart';
import 'package:mvp1/domain/reporting/enums/TimeRangeOfDay.dart';
import 'package:mvp1/domain/reporting/enums/days.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mvp1/providers/userProvider.dart';
import 'package:mvp1/widgets/safetext.dart';

Widget BuildAverageHeading(
    DateTimeRange? dateRange, Days days, TimeRangeOfDay dayTimeRange) {
  return Consumer(builder: (context, watch, child) {
    final selectedProfileId = watch(selectedProfileProvider).state;

    return ValueListenableBuilder<Box<Bp>>(
      valueListenable: BpRepository.GetBox().listenable(),
      builder: (context, box, _) {
        final readings = box.values
            .toList()
            .cast<Bp>()
            .where((element) => element.userId == selectedProfileId)
            .toList();
        if (readings.length == 0) {
          return Text(
            "No Readings Found",
            style: AppTypography.PrimaryText,
          );
        }
        var averageBp =
            BpRepository.GetAverageBp(days, dayTimeRange, dateRange, readings);

        // if (averageBp == null) {
        //   return Column(
        //     children: [
        //       NoReadings(),
        //     ],
        //   );
        // }

        return !(readings.length == 0 || averageBp == null)
            ? Column(
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
                        flex: 70,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            BuildSafeText(
                                '${averageBp.AverageSystolic}/${averageBp.AverageDiastolic}',
                                AppTypography.PrimaryHeadingThin),
                            BuildSafeText(" mmHg", AppTypography.SecondaryText)
                          ],
                        ),
                      ),
                      Flexible(
                          flex: 30,
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: BpRepository.GetBpStatusColor(
                                    BpRepository.GetBpStatusFromReadings(
                                        averageBp.AverageSystolic,
                                        averageBp.AverageDiastolic,
                                        averageBp.AveragePulse)),
                              ),
                              BuildSafeText(
                                  " ${BpRepository.GetBpStatusDisplayString(BpRepository.GetBpStatusFromReadings(averageBp.AverageSystolic, averageBp.AverageDiastolic, averageBp.AveragePulse))} ",
                                  AppTypography.PrimaryText)
                            ],
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              )
            : Text(
                "No Readings Found",
                style: AppTypography.PrimaryText,
              );
      },
    );
  });
}
