import 'package:intl/intl.dart';

String startTimeFormater(timestamp) {
  final startDate = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  final DateFormat timeFormatter = DateFormat('h:mm a');
  return timeFormatter.format(startDate);
}
