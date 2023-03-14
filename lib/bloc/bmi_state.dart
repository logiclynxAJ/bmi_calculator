// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bmi_bloc.dart';

class BmiState extends Equatable {
  final Gender gender;
  final Height heightUnit;
  final Weight weightUnit;
  final double height, weight;
  final int age;
  final GlobalKey<State<StatefulWidget>>? key;

  const BmiState({
    this.gender = Gender.male,
    this.heightUnit = Height.inch,
    this.weightUnit = Weight.lbs,
    this.height = 60,
    this.weight = 60,
    this.age = 22,
    this.key,
  });

  BmiState copyWith({
    Gender? gender,
    Height? heightUnit,
    Weight? weightUnit,
    double? height,
    double? weight,
    int? age,
    GlobalKey<State<StatefulWidget>>? key,
  }) {
    return BmiState(
      key: key ?? this.key,
      gender: gender ?? this.gender,
      heightUnit: heightUnit ?? this.heightUnit,
      weightUnit: weightUnit ?? this.weightUnit,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      age: age ?? this.age,
    );
  }

  @override
  List<Object?> get props =>
      [gender, heightUnit, weightUnit, weight, height, age, key];

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

    return double.parse(bmi.toStringAsFixed(2));
  }

  String get bmiShortMessage {
    if (bmi < 18.5) {
      return "Your BMI is $bmi, which is underweight. You may need to gain weight to improve your health.";
    } else if (bmi >= 18.5 && bmi < 25) {
      return "Your BMI is $bmi, which is normal. Keep up your healthy habits!";
    } else if (bmi >= 25 && bmi < 30) {
      return "Your BMI is $bmi, which is overweight. You may need to lose weight to improve your health.";
    } else {
      return "Your BMI is $bmi, which is obese. You may need to lose weight and consult a doctor to improve your health.";
    }
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
