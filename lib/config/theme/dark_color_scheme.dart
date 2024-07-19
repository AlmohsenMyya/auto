
part of 'app_theme.dart';


const _darkColorScheme = ColorScheme.dark(
  inversePrimary: Color(0xffffffff) ,

  primary : Colors.cyanAccent,
  onPrimary : Color(0xffffffff),

  primaryContainer: Color(0xffF7F7F7),
  onPrimaryContainer: Color.fromRGBO(39, 52, 68 ,1),


  secondary :Color(0xFF48b4e0),
  onSecondary : Color(0xFFFFFFFF),

  tertiary: Color(0xffEB6713),
  onTertiary: Color(0xFFFFFFFF),

  error : Color(0xFFFF0000),
  errorContainer : Color(0xFFF9DEDC),

  onError : Color(0xFFFFFFFF),
  onErrorContainer : Color(0xFF410E0B),

  background :Color(0xFFFFFFFF),
  onBackground :  Color(0xFFFFFFFF),

  surface : Color(0xFFFBFDFD),
  onSurface : Color(0xffffffff),

  surfaceVariant : Color(0xffF4F4F4),
  onSurfaceVariant :Color(0xFFFFFFFF) ,

  outline : Color(0xFF79747E),

  // onInverseSurface : Color(0xFFEFF1F1),
  // inverseSurface : Color(0xFF2D3132),
  onInverseSurface : Color(0xFF121212),
  inverseSurface : Color(0xFFE0E0E0),

  shadow :Colors.white,
);


ColorScheme get darkColorScheme=>_darkColorScheme;