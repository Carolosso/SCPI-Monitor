import 'dart:math';

/// Formatting value to SI base units. Returing formatted value.
/// * @rawValue
String formatUnit(String rawValue) {
  String newValue = "";
  //debugPrint(rawValue);
  if (rawValue.contains('e') || rawValue.contains('E')) {
    int lastDigit = int.parse(rawValue.substring(rawValue.length - 1));
    double value = double.parse(rawValue.substring(0, rawValue.length - 3));
    if (rawValue.contains('+')) {
      if (lastDigit > 3 && lastDigit <= 6) {
        value = value / pow(10, 6 - lastDigit);
        newValue = "${value.toStringAsFixed(3)} M";
      } else if (lastDigit == 3) {
        value = value / pow(10, 3 - lastDigit);
        newValue = "${value.toStringAsFixed(3)} k";
      } else if (lastDigit > 6 && lastDigit <= 9) {
        value = value / pow(10, 9 - lastDigit);
        newValue = "${value.toStringAsFixed(3)} G";
      } else {
        value = value * pow(10, lastDigit);
        newValue = "${value.toStringAsFixed(3)} ";
//          newValue = rawValue.substring(0, rawValue.length - 3);
      }
    } else if (rawValue.contains('-')) {
      if (lastDigit > 3 && lastDigit <= 6) {
        value = value * pow(10, 6 - lastDigit);
        newValue = "${value.toStringAsFixed(3)} u";
      } else if (lastDigit > 0 && lastDigit <= 3) {
        value = value * pow(10, 3 - lastDigit);
        newValue = "${value.toStringAsFixed(3)} m";
      } else if (lastDigit > 6 && lastDigit <= 9) {
        value = value * pow(10, 9 - lastDigit);
        newValue = "${value.toStringAsFixed(3)} n";
      } else if (lastDigit > 9 && lastDigit <= 12) {
        value = value * pow(10, 12 - lastDigit);
        newValue = "${value.toStringAsFixed(3)} p";
      }
    }
  } else {
    newValue = rawValue;
  }
  return newValue;
}
