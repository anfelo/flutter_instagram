import 'package:intl/intl.dart';

/// Static global state. Immutable services that do not care about build context.
class Global {
  // Formatters
  static final currFormater = NumberFormat('#,##0', 'en_US');
  static final dateFormater = DateFormat.yMMMMd("en_US");
  static final timeFormater = DateFormat.yMd("en_US").add_Hms();

  // RegExps
  static final RegExp emailRegExp = new RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
    caseSensitive: false,
    multiLine: false,
  );
}
