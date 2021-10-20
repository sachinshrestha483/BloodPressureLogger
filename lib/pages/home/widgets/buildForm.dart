import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget BuildForm(Widget form) {
  return Row(
    children: [
      Expanded(
        flex: 1, // takes 30% of available width
        child: SizedBox(),
      ),
      Expanded(flex: 8, child: form),
      Expanded(
        flex: 1, // takes 30% of available width
        child: SizedBox(),
      ),
    ],
  );
}
