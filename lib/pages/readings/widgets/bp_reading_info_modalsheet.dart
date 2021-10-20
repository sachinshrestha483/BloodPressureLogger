import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvp1/config/config.dart';
import 'package:mvp1/config/modal_bottomsheetStyle.dart';
import 'package:mvp1/config/typography.dart';
import 'package:mvp1/domain/bp_repository/src/bp_repository.dart';
import 'package:mvp1/domain/bp_repository/src/models/models.dart';
import 'package:mvp1/widgets/widgets.dart';

Future<void> ShowBpInfoBottomModalSheet(BuildContext context, Bp bp) {
  return showModalBottomSheet<void>(
      shape: ModalBottomSheetStyle.modalBottomSheetShape,
      backgroundColor: Pallete.ModalBottomSheetBgColor,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Flexible(
                    flex: 8,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            BuildSafeText(
                                "Bp Detail", AppTypography.cardHeading,
                                textAlign: TextAlign.left),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "❤️",
                                  style: TextStyle(fontSize: 45),
                                ),
                                SizedBox(
                                  width: 18,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${bp.systolic}/${bp.diastolic} ",
                                          style: TextStyle(fontSize: 25),
                                        ),
                                        Text(
                                          " ${BpRepository.GetBpStatusDisplayString(BpRepository.GetBpStatus(bp))}",
                                          style: TextStyle(
                                              color:
                                                  BpRepository.GetBpStatusColor(
                                                      BpRepository.GetBpStatus(
                                                          bp)),
                                              fontSize: 22),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${bp.pulse}",
                                      style: TextStyle(fontSize: 20),
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                        " ${bp.readingDateTime.toLocal().day}/${bp.readingDateTime.toLocal().month}/${bp.readingDateTime.toLocal().year}, ${bp.readingDateTime.toLocal().hour}:${bp.readingDateTime.toLocal().minute} ",
                                        style: TextStyle(fontSize: 20))
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            BuildSafeText(BpRepository.GetBpInfo(bp).summary,
                                AppTypography.PrimaryText,
                                textAlign: TextAlign.left, maxlines: 5),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child:
                          PrimaryButton(()=>{
                                  Navigator.pop(context)

                          }, "Close")
                        ),
                        Expanded(flex: 2, child: SizedBox()),
                        Expanded(
                          flex: 4,
                          child: 
                          DangerButton(()=>{
                             BpRepository.Remove(bp.key),
                                  Navigator.pop(context),

                          }, "Delete")
                          
                         
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}
