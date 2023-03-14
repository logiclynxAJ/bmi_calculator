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

    if (bmi > 30) return 30;

    return bmi;
  }

  String get bmiMessage {
    if (bmi < 18.5) {
      return "Your BMI is $bmi, which is considered underweight. This may put you at risk for health problems, such as weakened immune system, anemia, and osteoporosis. You may need to gain weight to improve your health. Please consult a doctor for guidance.";
    } else if (bmi >= 18.5 && bmi < 25) {
      return "Your BMI is $bmi, which is considered normal. This range is associated with a lower risk of chronic diseases, such as heart disease and diabetes. Keep up your healthy habits such as eating a balanced diet and exercising regularly!";
    } else if (bmi >= 25 && bmi < 30) {
      return "Your BMI is $bmi, which is considered overweight. This may put you at risk for health problems, such as high blood pressure, high cholesterol, and type 2 diabetes. You may need to lose weight to improve your health. Please consult a doctor for guidance.";
    } else {
      return "Your BMI is $bmi, which is considered obese. This may put you at risk for serious health problems, such as heart disease, stroke, and some cancers. You may need to lose weight and consult a doctor for guidance on improving your health.";
    }
  }

  String get bmiStatus {
    if (bmi < 18.5) {
      return "Underweight";
    } else if (bmi >= 18.5 && bmi < 25) {
      return "Healthy";
    } else if (bmi >= 25 && bmi < 30) {
      return "Overweight";
    } else {
      return "Obese";
    }
  }
}
