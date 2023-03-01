//This Function Is To Extract Only Year, Month, And Day From A Given Date
import 'package:flutter/material.dart';

DateTime dateOnly(DateTime inputDateTime) {
  return DateTime(inputDateTime.year, inputDateTime.month, inputDateTime.day);
}

String getFormattedTime({required BuildContext context, required String time}) {
  final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
  return TimeOfDay.fromDateTime(date).format(context);
}

getLastMessageTime({required BuildContext context, required String time}) {
  final DateTime sent = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
  final DateTime now = DateTime.now();
  if (now.day == sent.day && now.month == sent.month && now.year == sent.year) {
    return TimeOfDay.fromDateTime(sent).format(context);
  }
  return '${sent.day} ${_getMonth(sent)}';
}

String _getMonth(DateTime date) {
  switch (date.month) {
    case 1:
      return 'Jan';
    case 2:
      return 'Feb';
    case 3:
      return 'Mar';
    case 4:
      return 'Apr';
    case 5:
      return 'May';
    case 6:
      return 'Jun';
    case 7:
      return 'Jul';
    case 8:
      return 'Aug';
    case 9:
      return 'Sept';
    case 10:
      return 'Oct';
    case 11:
      return 'Nov';
    case 12:
      return 'Dec';
  }
  return 'NA';
}
