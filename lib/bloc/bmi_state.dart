// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bmi_bloc.dart';

class BmiState extends Equatable {
  final Gender gender;
  final Height heightUnit;
  final Weight weightUnit;
  final double height, weight;
  final int age;

  const BmiState({
    this.gender = Gender.male,
    this.heightUnit = Height.inch,
    this.weightUnit = Weight.lbs,
    this.height = 60,
    this.weight = 60,
    this.age = 22,
  });

  BmiState copyWith({
    Gender? gender,
    Height? heightUnit,
    Weight? weightUnit,
    double? height,
    double? weight,
    int? age,
  }) {
    return BmiState(
      gender: gender ?? this.gender,
      heightUnit: heightUnit ?? this.heightUnit,
      weightUnit: weightUnit ?? this.weightUnit,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      age: age ?? this.age,
    );
  }

  @override
  List<Object> get props =>
      [gender, heightUnit, weightUnit, weight, height, age];

  String get formattedHeight => heightUnit == Height.inch
      ? formatAsFeetAndInchesAndCms(height)
      : inchesToCmAndFeet(height);

  int get heightInFeet => convertToFeet(height);
  int get heightInInches => (height - (heightInFeet * 12)).toInt();

  int get weightInKgs => weight.toInt();
  int get weightInlbs => convertKgsToLbs(weight).toInt();

  String get formattedWeight =>
      (weightUnit == Weight.lbs ? weightInlbs : weightInKgs).toString();

  double get bmi {
    // convert height from inches to meters
    double heightMeters = height * 0.0254;

    // calculate BMI
    double bmi = weightInKgs / (heightMeters * heightMeters);

    return bmi;
  }
}
