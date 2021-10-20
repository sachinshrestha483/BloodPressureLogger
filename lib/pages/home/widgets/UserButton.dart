import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvp1/config/pallete.dart';
import 'package:mvp1/config/typography.dart';
import 'package:mvp1/widgets/safetext.dart';

Widget BuildUserButton(
  Function fun,
  String text,
) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0,8,0,8),
    child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Pallete.chooseUserButtonColor)),
        onPressed: () {
          fun();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BuildSafeText(text, AppTypography.PrimaryTextStyle),
              Icon(Icons.arrow_forward)
            ],
          ),
        )),
  );
}
