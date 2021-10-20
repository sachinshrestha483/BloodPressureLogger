import 'package:flutter/cupertino.dart';
import 'package:mvp1/config/typography.dart';

Widget BuildSafeText(String text, TextStyle textStyle,{TextAlign textAlign=TextAlign.center, int maxlines = 1} ) {
  return Flexible(
    child: Text(
      text,
      textAlign: textAlign,
      style: textStyle,
      overflow: TextOverflow.ellipsis,
      maxLines: maxlines,
    ),
  );
}
