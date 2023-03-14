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

List<Color> generateColorList(Color baseColor, {int length = 10}) {
  // Create a list to store the shades of the base color
  List<Color> colorList = [];

  // Extract the RGB components of the base color
  int red = baseColor.red;
  int green = baseColor.green;
  int blue = baseColor.blue;

  // Generate 10 shades of the base color
  for (int i = 1; i <= length + 1; i++) {
    // Calculate the shade factor
    double factor = i / length;

    // Calculate the new RGB values based on the shade factor
    int newRed = (red * factor).round();
    int newGreen = (green * factor).round();
    int newBlue = (blue * factor).round();

    // Create the new color and add it to the list
    Color newColor = Color.fromARGB(255, newRed, newGreen, newBlue);
    colorList.add(newColor);
  }

  // Return the list of shades
  return colorList;
}
