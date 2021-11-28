import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvp1/config/config.dart';
import 'package:mvp1/config/modal_bottomsheetStyle.dart';
import 'package:mvp1/config/typography.dart';
import 'package:mvp1/domain/bp_repository/src/bp_repository.dart';
import 'package:mvp1/domain/bp_repository/src/models/models.dart';
import 'package:mvp1/pages/reminders/widgets/addReminderForm.dart';
import 'package:mvp1/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> AddReminderBottomModalSheet(
  BuildContext context,
) {
  return showModalBottomSheet<void>(
      shape: ModalBottomSheetStyle.modalBottomSheetShape,
      backgroundColor: Pallete.ModalBottomSheetBgColor,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            height: 800,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Flexible(
                    flex: 8,
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            BuildSafeText(
                                "Add Reminder", AppTypography.cardHeading,
                                textAlign: TextAlign.left),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        AddReminderForm()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
