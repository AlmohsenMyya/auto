part of 'typography.dart';

FontWeight get _light => FontWeight.w300;

FontWeight get _regular => FontWeight.normal;

FontWeight get _medium => FontWeight.w500;

FontWeight get _semiBold => FontWeight.w600;

FontWeight get _bold => FontWeight.bold;

FontWeight get _thin => FontWeight.w400;

String get _sFTextSemiBoldFamily => 'SF-Pro-Text-Semibold';

String get _sFTextRegularFamily => 'SF-Pro-Text-Regular';

String get _sFDisplayRegularFamily => 'SF-Pro-Display-Regular';

String get _sFDisplaySemiBoldFamily => 'SF-Pro-Display-Semibold';

String get _sFDisplayThinFamily => 'SF-Pro-Display-Thin';

String get _sFDisplayLightFamily => 'SF-Pro-Display-Light';

String get _sFRoundedLightFamily => 'SF-Pro-Rounded-Light';

String get _sFRoundedBoldFamily => 'SF-Pro-Rounded-Bold';

String get _sFRoundedRegularFamily => 'SF-Pro-Rounded-Regular';

String get _sFRoundedMediumFamily => 'SF-Pro-Rounded-Medium';

String get _sFDisplayBoldFamily => 'SF-Pro-Display-Bold';

String get _sFAdobeCleanLightFamily => 'AdobeCleanLight';

String get _sFAdobeCleanRegularFamily => 'AdobeCleanRegular';

String get _sFAdobeCleanBoldFamily => 'AdobeCleanBold';

String get _sFCairoBoldFamily => 'Cairo';
String get _sFCairoRegularFamily => 'CairoRegular';
String get _sFCairoSemiBoldFamily => 'CairoSemiBold';
String get _sFAlexandriaFamily => 'Alexandria';

extension FamilyUtils on TextStyle {
  TextStyle get cairoBold =>
      copyWith(fontWeight: _semiBold, fontFamily: _sFCairoBoldFamily);
  TextStyle get sbd =>
      copyWith(fontWeight: _semiBold, fontFamily: _sFDisplaySemiBoldFamily);





  TextStyle get bd =>
      copyWith(fontWeight: _regular, fontFamily: _sFDisplayBoldFamily);

  TextStyle get rd =>
      copyWith(fontWeight: _bold, fontFamily: _sFDisplayRegularFamily);

  TextStyle get sbt =>
      copyWith(fontWeight: _semiBold, fontFamily: _sFTextSemiBoldFamily);

  TextStyle get td =>
      copyWith(fontWeight: _thin, fontFamily: _sFDisplayThinFamily);

  TextStyle get rt =>
      copyWith(fontWeight: _regular, fontFamily: _sFTextRegularFamily);

  TextStyle get ld =>
      copyWith(fontWeight: _light, fontFamily: _sFDisplayLightFamily);

  TextStyle get lr =>
      copyWith(fontWeight: _light, fontFamily: _sFRoundedLightFamily);

  TextStyle get rr =>
      copyWith(fontWeight: _regular, fontFamily: _sFRoundedRegularFamily);

  TextStyle get mr =>
      copyWith(fontWeight: _medium, fontFamily: _sFRoundedMediumFamily);

  TextStyle get br =>
      copyWith(fontWeight: _bold, fontFamily: _sFRoundedBoldFamily);

  TextStyle get la =>
      copyWith(fontWeight: _light, fontFamily: _sFAdobeCleanLightFamily);

  TextStyle get ra =>
      copyWith(fontWeight: _regular, fontFamily: _sFAdobeCleanRegularFamily);

  TextStyle get ba =>
      copyWith(fontWeight: _bold, fontFamily: _sFAdobeCleanBoldFamily);
}

abstract class _FontSize {
  static double get huge => _hugeFontSize.sp;

  static const double _hugeFontSize = 20;

  static double get heading_01 => _heading_01FontSize.sp;

  static const double _heading_01FontSize = 46;

  static double get heading_02 => _heading_02FontSize.sp;

  static const double _heading_02FontSize = 36;

  static double get heading_03 => _heading_03FontSize.sp;

  static const double _heading_03FontSize = 30;

  static double get heading_04 => _heading_04FontSize.sp;

  static const double _heading_04FontSize = 14;

  static double get heading_05 => _heading_05FontSize.sp;

  static const double _heading_05FontSize = 14;

  static double get heading_06 => _heading_06FontSize.sp;

  static const double _heading_06FontSize = 22;

  static double get subtitle_01 => _subtitle_01FontSize.sp;

  static const double _subtitle_01FontSize = 18;

  static double get subtitle_02 => _subtitle_02FontSize.sp;

  static const double _subtitle_02FontSize = 12;

  static double get button => _buttonFontSize.sp;

  static const double _buttonFontSize = 18;

  static double get body_01 => _body_01FontSize.sp;

  static const double _body_01FontSize = 16;

  static double get body_02 => _body_02FontSize.sp;

  static const double _body_02FontSize = 14;

  static double get caption => _captionFontSize.sp;

  static const double _captionFontSize = 12;

  static double get overline => _overlineFontSize.sp;

  static const double _overlineFontSize = 10;
}
