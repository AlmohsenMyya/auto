import 'package:auto2/core/utils/extension/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MainButton extends StatelessWidget {
  const MainButton(
      {Key? key,
        this.textStyle,
      required this.text,
      this.width,
      this.height,
      this.fontSize,
      this.borderRadius,
      this.shadowColor,
      this.icon,
      required this.color,
      required this.onPressed,
      this.textColor,
      this.borderColor,
      this.elevation})
      : super(key: key);
final TextStyle? textStyle;
  final String text;
  final double? width;
  final double? height;
  final double? fontSize;
  final Color color;
  final Color? textColor;
  final VoidCallback? onPressed;
  final BorderRadiusGeometry? borderRadius;
  final Color? shadowColor;
  final Color? borderColor;
  final Widget? icon;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(overlayColor:MaterialStateProperty.all(Colors.blue),
        elevation: MaterialStatePropertyAll(elevation),
        shadowColor: shadowColor != null ? MaterialStateProperty.all(shadowColor) : null,
        backgroundColor: MaterialStateProperty.all(color),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(50.r),
            side: BorderSide(color: borderColor ?? Colors.transparent),
          ),
        ),
        fixedSize: MaterialStateProperty.all(
          Size(
            width ?? .3.sw,
            height ?? .13.sw,
          ),
        ),
      ),
      onPressed: (onPressed != null)
          ? () {
              FocusManager.instance.primaryFocus?.unfocus();
              onPressed!();
            }
          : null,
      child: FittedBox(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
              textStyle??

              context.exTextTheme.titleLarge!.copyWith(color: textColor ?? context.theme.colorScheme.onPrimary),


            ),
            if (icon != null) ...[
              const SizedBox(width: 10),
              icon!,
            ],
          ],
        ),
      ),
    );
  }
}
