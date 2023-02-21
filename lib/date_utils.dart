//This Function Is To Extract Only Year, Month, And Day From A Given Date
DateTime dateOnly(DateTime inputDateTime) {
  return DateTime(inputDateTime.year, inputDateTime.month, inputDateTime.day);
}
