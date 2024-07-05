import 'package:flutter/material.dart';
import '../colors.dart';
import '../utils.dart';

enum TextStyleType {
  title, // 40px
  subTitle, // 25px
  bodyBig, // 22px
  body, // 20px
  small, // 14px
  custom,
}

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.textType,
    required this.text,
    this.textColor = AppColors.mainWhiteColor,
    this.fontSize,
    this.fontWeight,
    this.textAlign = TextAlign.center,
    this.textDecoration = TextDecoration.none,
    this.overflow,
    this.decorationThickness,
    this.decorationColor,
  });

  final TextStyleType textType;
  final String text;
  final Color? textColor;
  final Color? decorationColor;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final TextOverflow? overflow;
  final double? decorationThickness;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      softWrap: true,
      //maxLines: 6,
      // textScaleFactor: 1.0,
      style: getTextStyle(),
    );
  }

  TextStyle getTextStyle() {
    switch (textType) {
      case TextStyleType.title:
        return TextStyle(
          height: 1.2,
          decoration: textDecoration,
          color: textColor,
          fontSize: screenWidth(30),
          fontWeight: FontWeight.w900,
        );

      case TextStyleType.subTitle:
        return TextStyle(
          height: 1.2,
          decoration: textDecoration,
          color: textColor,
          fontSize: screenWidth(30),
          //fontWeight: fontWeight ?? FontWeight.w400,
        );

      case TextStyleType.bodyBig:
        return TextStyle(
          height: 1.2,
          decoration: textDecoration,
          color: textColor,
          fontSize: screenWidth(10),
          // fontWeight: fontWeight ?? FontWeight.w700,
        );

      case TextStyleType.body:
        return TextStyle(
          height: 1.2,
          decoration: textDecoration,
          color: textColor,
          fontSize: screenWidth(25),
          //fontWeight: fontWeight ?? FontWeight.w400,
        );

      case TextStyleType.small:
        return TextStyle(
          height: 1.2,
          decoration: textDecoration,
          color: textColor,
          fontSize: screenWidth(32),
          //fontWeight: fontWeight ?? FontWeight.w400,
        );

      case TextStyleType.custom:
        return TextStyle(
          height: 1.2,
          decoration: textDecoration,
          decorationColor: decorationColor,
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          decorationThickness: decorationThickness ?? 0,
        );
    }
  }
}
