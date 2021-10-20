import 'package:flutter/widgets.dart';
import 'package:mvp1/config/typography.dart';
import 'package:mvp1/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget BuildPrimaryButton(Function fun, Widget child) {
  return ElevatedButton(
      onPressed: () {
        print("Button Pressed");
        fun();
      },
      child: Padding(padding: const EdgeInsets.all(16.0), child: child));
}





