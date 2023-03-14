import 'package:flutter/material.dart';

String formatAsFeetAndInches(double inches) {
  int feet = inches ~/ 12;
  int remainingInches = (inches % 12).round();
  String result = '$feet ft';
  if (remainingInches > 0) {
    result += ' $remainingInches inches';
  }
  return result;
}

String formatAsFeetAndInchesAndCms(double inches) {
  int feet = inches ~/ 12;
  int remainingInches = (inches % 12).round();
  String result = '$feet ft';
  if (remainingInches > 0) {
    result += ' $remainingInches inches';
  }
  result += ' (${inchesToCm(inches)})';
  return result;
}

String inchesToCm(double inches) {
  return '${(inches * 2.54).toStringAsFixed(2)} cm'; // 1 inch is equal to 2.54 cm
}

num inchToCm(double inches) {
  return (inches * 2.54).toInt(); // 1 inch is equal to 2.54 cm
}

double cmToInch(double cm) {
  return cm / 2.54;
}

String inchesToCmAndFeet(double inches) {
  return '${inchesToCm(inches)} (${formatAsFeetAndInches(inches)})'; // 1 inch is equal to 2.54 cm
}

int convertToFeet(double inches) {
  int feet = inches ~/ 12; // integer division to get the whole number of feet
  return feet;
}

TextTheme textThemeOf(BuildContext context) => Theme.of(context).textTheme;

String describeEnumType(Enum enumEntry) {
  final String description = enumEntry.toString();
  final int indexOfDot = description.indexOf('.');
  assert(
    indexOfDot != -1 && indexOfDot < description.length - 1,
    'The provided object "$enumEntry" is not an enum.',
  );
  return description.substring(0, indexOfDot);
}

double convertKgsToLbs(double kgs) {
  double lbs = kgs * 2.20462;
  return lbs;
}

double convertLbsToKgs(double lbs) {
  double kgs = lbs / 2.20462;
  return kgs;
}

extension EnumType on Enum {
  String get type => describeEnumType(this);
}
