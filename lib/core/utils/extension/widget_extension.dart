import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget positioned({
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) =>
      Positioned(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
        child: this,
      );

  Widget directionalPadding(EdgeInsetsDirectional padding) => Padding(padding: padding, child: this);
  Widget padding(EdgeInsetsGeometry padding) => Padding(padding: padding, child: this);
  // Widget directionalPadding(EdgeInsetsGeometry padding) => Padding(padding: padding, child: this);

  Widget paddingAll(double value) => Padding(padding: EdgeInsets.all(value), child: this);

  Widget paddingHorizontal(double value) => Padding(
    padding: EdgeInsets.symmetric(horizontal: value),
    child: this,
  );

  Widget paddingVertical(double value) => Padding(
    padding: EdgeInsets.symmetric(vertical: value),
    child: this,
  );

  Widget onTap(Function()? onPressed, {Color? splashColor}) => InkWell(
    hoverColor: splashColor,
    highlightColor: splashColor,
    splashColor: splashColor,
    onTap: onPressed,
    child: this,
  );

  Widget scrollable({
    Axis scrollDirection = Axis.vertical,
  }) =>
      SingleChildScrollView(
        scrollDirection: scrollDirection,
        child: this,
      );

  Widget center() => Center(child: this);

  Widget expand({int flex = 1}) => Expanded(flex: flex, child: this);

  Widget hero(String tag) => Hero(
    tag: tag,
    transitionOnUserGestures: true,
    child: this,
    // flightShuttleBuilder: (_, animation, __, ___, ____) {
    // final customAnimation = Tween<double>(begin: 0, end: 10).animate(animation);
    // return AnimatedBuilder(
    //   animation: animation,
    //   builder: (context, child) {
    //     return Transform(
    //       transform: Matrix4.identity()
    //         ..setEntry(3, 2, .005)
    //         ..rotateZ(customAnimation.value * pi),
    //       alignment: AlignmentDirectional.centerStart,
    //       child: this,
    //     );
    //   },
    // );
    // return ScaleTransition(
    //   scale: animation,
    //   child: this,
    // );
    // },
  );
}
