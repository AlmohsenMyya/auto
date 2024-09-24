  import 'package:auto2/core/utils/extension/widget_extension.dart';
import 'package:flutter/material.dart';
class MainAppBar extends AppBar {
  MainAppBar(
      {
        showArrowBack=true,
        Key? key,
        this.backGroundColor,
      this.titleTextStyle,
      this.actionsWidget = const [],
      required this.titleText,
      this.leadingWidget ,
      this.foreColor,
      this.size,
      this.bottomWidget,
      this.fontSize,
      this.shape1,
      this.onTap,
      this.textStyle})
      : super(backgroundColor: backGroundColor,
          key: key,
          toolbarHeight: size != null ? size.width * .15 : null,
          foregroundColor: foreColor,
          leading:
          showArrowBack?const Icon(Icons.arrow_back_ios_new_rounded
            // , color: Colors.black,


          ).onTap(() => onTap?.call()):
          null

          ,

          actions: actionsWidget,
          centerTitle: true,
          titleTextStyle: titleTextStyle ,
          elevation: 0,
          shape: shape1 ??
              RoundedRectangleBorder(
                  side: BorderSide(
                color: Colors.grey.shade100,
              )),
          title: GestureDetector(
            child: Text(titleText,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          bottom: bottomWidget,
        );
  final Size? size;
 bool? showArrowBack;
 final Color? backGroundColor;
  final TextStyle? titleTextStyle;
  final String titleText;
  final TextStyle? textStyle;
  final Color? foreColor;
  final ShapeBorder? shape1;
  final List<Widget> actionsWidget;
  final double? fontSize;
  final PreferredSizeWidget? bottomWidget;
  final Widget? leadingWidget;
  final VoidCallback? onTap;
}
