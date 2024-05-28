import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../colors.dart';
import '../utils.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? textSize;
  final FontWeight? textFontWight;
  final Color? borderColor;
  final Color? backgroundColor;
  final void Function()? onPressed;
  final String? svgName;
  final Color? colorSvg;
  final double? widthButton;
  final double? heightButton;
  final double? circularBorder;

  const CustomButton({
    super.key,
    required this.text,
    this.textColor,
    this.textSize,
    this.textFontWight,
    this.borderColor,
    this.backgroundColor,
    required this.onPressed,
    this.svgName,
    this.colorSvg,
    this.widthButton,
    this.heightButton,
    this.circularBorder,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.blueB4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(circularBorder ?? screenWidth(0))),
        side: borderColor != null
            ? BorderSide(width: 1, color: borderColor ?? AppColors.blueB4)
            : null,
        fixedSize: Size(screenWidth(widthButton ?? 1), screenWidth(heightButton ?? 7)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (svgName != null) ...[
            SizedBox(
                width: screenWidth(10),
                child: SvgPicture.asset(
                  'images/$svgName.svg',
                )),
            // SizedBox(
            //   width: screenWidth(15),
            // )
          ],
          Text(
            text,
            style: TextStyle(
              color: textColor ?? AppColors.mainWhiteColor,
              fontSize: textSize ?? screenWidth(22),
              fontWeight: textFontWight ?? FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
