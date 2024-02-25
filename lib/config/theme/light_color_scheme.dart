part of 'app_theme.dart';


const _lightColorScheme = ColorScheme.light(

  primary :  Color(0xFF48b4e0),
  onPrimary : Color(0xffffffff),
  // onPrimary : Color(0xffF5F5F5),

  primaryContainer: Color(0xff636363),
  onPrimaryContainer: Color(0xffF7F7F7),


  secondary :  Color(0xFF0196FD),
  onSecondary :  Color(0xFF59D4FE),

  tertiary: Color(0xffEB6713),
  onTertiary: Color(0xFFFFFFFF),

  error : Colors.red,
  errorContainer : Color(0xFFF9DEDC),

  onError : Color(0xFFFFFFFF),
  onErrorContainer : Color(0xFF410E0B),

  background : Color(0xFFFFFFFF),
  onBackground :Color(0xFF000000),

  surface : Color(0xFFFBFDFD),
  onSurface : Color(0xFF191C1D),

  surfaceVariant : Color(0xffF4F4F4),
  onSurfaceVariant : Color(0xFF49454F),

  outline : Color(0xFF79747E),

  onInverseSurface : Color(0xFFEFF1F1),
  inverseSurface : Color(0xFF2D3132),

  shadow : Colors.grey,
);

ColorScheme get lightColorScheme=>_lightColorScheme;
