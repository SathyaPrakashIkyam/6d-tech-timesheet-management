
import 'package:intl/intl.dart';

getDate(String today) {
  DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(today);
  // Format the parsed date to 'yyyy-MM-dd'
  String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
  return formattedDate;
}