import 'package:intl/intl.dart';

class DateFormatService {
  static String formatDate(DateTime date, {String format = 'dd/MM/yyyy'}) {
    final DateFormat dateFormat = DateFormat(format);
    return dateFormat.format(date);
  }
}
