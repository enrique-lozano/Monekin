import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';

/// The decimal separator of the current locale of the app
String get currentDecimalSep {


  // Get the locale, replacing '-' with '_', or default to 'en'


  String locale = Intl.defaultLocale?.replaceAll('-', '_') ?? 'en';


  


  // Access the number format symbols


  var symbols = numberFormatSymbols[locale] ?? numberFormatSymbols['en'];





  // Return the DECIMAL_SEP, providing a default value if it's null


  return symbols?.DECIMAL_SEP ?? '.'; // Default to '.' if DECIMAL_SEP is null


}