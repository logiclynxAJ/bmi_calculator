// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bmi_bloc.dart';

class BmiState extends Equatable {
  final Gender gender;
  final Height heightUnit;
  final Weight weightUnit;
  final double height, weight;

  const BmiState({
    this.gender = Gender.male,
    this.heightUnit = Height.cms,
    this.weightUnit = Weight.kgs,
    this.height = 60,
    this.weight = 60,
  });

  BmiState copyWith({
    Gender? gender,
    Height? heightUnit,
    Weight? weightUnit,
    double? height,
    double? weight,
  }) {
    return BmiState(
      gender: gender ?? this.gender,
      heightUnit: heightUnit ?? this.heightUnit,
      weightUnit: weightUnit ?? this.weightUnit,
      weight: weight ?? this.weight,
      height: height ?? this.height,
    );
  }

  @override
  List<Object> get props => [gender, heightUnit, weightUnit, weight, height];

  String get formattedHeight => heightUnit == Height.fts
      ? formatAsFeetAndInchesAndCms(height)
      : inchesToCmAndFeet(height);

  int get heightInFeet => convertToFeet(height);
  int get heightInInches => (height - (heightInFeet * 12)).toInt();
}
