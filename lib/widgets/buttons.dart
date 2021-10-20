import 'package:flutter/widgets.dart';
import 'package:mvp1/config/config.dart';
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

Widget PrimaryButton(Function fun, String text) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Pallete.lightBlue)),
        onPressed: () {
          fun();
        },
        child: Text(
          text,
          style: TextStyle(color: Pallete.ExtraDarkBlue),
        )),
  );
}

Widget DangerButton(Function fun, String text) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Pallete.LightRed)),
        onPressed: () {
          fun();
        },
        child: Text(
          "Delete",
          style: TextStyle(color: Pallete.White),
        )),
  );
}

Widget LargePrimaryButton(Function fun, List<Widget> widgets){

return SizedBox();


}



