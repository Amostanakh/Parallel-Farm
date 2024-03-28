bool hasNumber(String str) {
  final pattern = RegExp(r'\d'); // Matches any single digit
  return pattern.hasMatch(str);
}