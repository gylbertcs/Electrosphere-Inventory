import 'package:intl/intl.dart';

class AppFormat {
  static String currency(String number){
    return NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 2).format(double.parse(number));
  }

  static String date(String date) {
    DateTime dateTime = DateTime.parse(date).toLocal();
    return DateFormat('EEE, d MMMM yyyy').format(dateTime);
  }
}