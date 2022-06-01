import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static Color primaryColor = const Color(0xFFFFFFFF);
  static Color searchScreenBGColor = const Color(0xFFFFFFFF);
  static Color searchButtonColor = const Color(0xff2F3133);
  static Color blueColor = const Color(0xff56A0EA);

  static var logoStyle = GoogleFonts.montserrat(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
  );

  static var searchTextStyle = GoogleFonts.montserrat(
    color: const Color(0xff1e1e1e),
    fontSize: 15.0,
  );

  static var headerStyle = GoogleFonts.montserrat(
    fontSize: 22.0,
    color: const Color(0xff56A0EA),
  );

  static var errorMessageSmallTextStyle = GoogleFonts.montserrat(
    fontSize: 15.0,
    color: const Color(0xffBDC1C2),
  );
}
