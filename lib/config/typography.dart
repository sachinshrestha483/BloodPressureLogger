import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvp1/config/config.dart';

class AppTypography {
  static TextStyle PrimaryTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static TextStyle PrimaryHeading = TextStyle(
      fontSize: 35, fontWeight: FontWeight.bold, color: Pallete.GrayTextColor);

  static TextStyle cardHeading = TextStyle(
      fontSize: 28, fontWeight: FontWeight.bold, color: Pallete.GrayTextColor);

    static TextStyle PrimaryText = TextStyle(
      fontSize: 18, fontWeight: FontWeight.normal, color: Pallete.GrayTextColor);    
      static TextStyle SecondaryText = TextStyle(
      fontSize: 16, fontWeight: FontWeight.normal, color: Pallete.GrayTextColor);    


      static TextStyle PrimaryHeadingThin = TextStyle(
      fontSize: 30, fontWeight: FontWeight.normal, color: Pallete.GrayTextColor);

      
      static TextStyle TableHeading = TextStyle(
      fontSize: 12, fontWeight: FontWeight.normal, color: Pallete.GrayTextColor);

      static TextStyle TableBody = TextStyle(
      fontSize: 20, fontWeight: FontWeight.normal, color: Pallete.GrayTextColor);


      static TextStyle TableInfo = TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[800]);


}
