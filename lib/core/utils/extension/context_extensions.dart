import 'package:flutter/material.dart';

double tabletBreakpointGlobal = 600.0;
double desktopBreakpointGlobal = 720.0;

// Context Extensions
extension ContextExtensions on BuildContext {
  /// return screen size
  Size size() => MediaQuery.of(this).size;

  /// return screen width
  double width() => MediaQuery.of(this).size.width;

  /// return screen height
  double height() => MediaQuery.of(this).size.height;

  /// return screen devicePixelRatio
  double pixelRatio() => MediaQuery.of(this).devicePixelRatio;

  /// returns brightness
  Brightness platformBrightness() => MediaQuery.of(this).platformBrightness;

  /// Return the height of status bar
  double get statusBarHeight => MediaQuery.of(this).padding.top;

  /// Return the height of navigation bar
  double get navigationBarHeight => MediaQuery.of(this).padding.bottom;

  /// Returns Theme.of(context)
  ThemeData get theme => Theme.of(this);

  /// Returns Theme.of(context).textTheme
  TextTheme get exTextTheme => Theme.of(this).textTheme;

  /// Returns DefaultTextStyle.of(context)
  DefaultTextStyle get defaultTextStyle => DefaultTextStyle.of(this);

  /// Returns Form.of(context)
  FormState? get formState => Form.of(this);

  /// Returns Scaffold.of(context)
  ScaffoldState get scaffoldState => Scaffold.of(this);

  /// Returns Overlay.of(context)
  OverlayState? get overlayState => Overlay.of(this);

  /// Returns primaryColor Color
  Color get primaryColor => theme.primaryColor;



  Color get exPrimaryContainer => theme.colorScheme.primaryContainer;
  Color get exSecondary => theme.colorScheme.secondary;
  Color get exOnSecondary => theme.colorScheme.onSecondary;
  Color get exOnBackground => theme.colorScheme.onBackground;
  Color get exBackground => theme.colorScheme.background;
  Color get exPrimaryColor => theme.colorScheme.primary;
  Color get exOnPrimaryContainer => theme.colorScheme.onPrimaryContainer;
  Color get exSurface => theme.colorScheme.surface;
  Color get exOutLine => theme.colorScheme.outline;





  /// Returns accentColor Color
  Color get accentColor => theme.colorScheme.secondary;

  /// Returns scaffoldBackgroundColor Color
  Color get scaffoldBackgroundColor => theme.scaffoldBackgroundColor;

  /// Request focus to given FocusNode
  void requestFocus(FocusNode focus) {
    FocusScope.of(this).requestFocus(focus);
  }

  /// Request focus to given FocusNode
  void unFocus(FocusNode focus) {
    focus.unfocus();
  }

  bool isPhone() => MediaQuery.of(this).size.width < tabletBreakpointGlobal;

  bool isTablet() =>
      MediaQuery.of(this).size.width < desktopBreakpointGlobal &&
          MediaQuery.of(this).size.width >= tabletBreakpointGlobal;

  bool isDesktop() => MediaQuery.of(this).size.width >= desktopBreakpointGlobal;

  Orientation get orientation => MediaQuery.of(this).orientation;

  bool get isLandscape => orientation == Orientation.landscape;

  bool get isPortrait => orientation == Orientation.portrait;

  bool get canPop => Navigator.canPop(this);

  // void pop<T extends Object>([T? result]) => Navigator.pop(this, result);

  TargetPlatform get platform => Theme.of(this).platform;

  bool get isAndroid => platform == TargetPlatform.android;

  bool get isIOS => platform == TargetPlatform.iOS;

  void openDrawer() => Scaffold.of(this).openDrawer();

  void openEndDrawer() => Scaffold.of(this).openEndDrawer();
}
