import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';

/// The decimal separator of the current locale of the app
String get currentDecimalSep =>
    numberFormatSymbols[Intl.defaultLocale?.replaceAll('-', '_') ?? 'en']
        ?.DECIMAL_SEP;
