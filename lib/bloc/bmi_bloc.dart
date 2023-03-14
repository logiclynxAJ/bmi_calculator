import 'package:bmi_calculator/common/types.dart';
import 'package:bmi_calculator/common/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bmi_event.dart';
part 'bmi_state.dart';

typedef StateEmitter = Emitter<BmiState>;

class BmiBloc extends Bloc<BmiEvent, BmiState> {
  BmiBloc() : super(const BmiState()) {
    on<UpdateGender>(_updateGender);
    on<UpdateHeightUnit>(_updateHeightUnit);
    on<UpdateWeightUnit>(_updateWeightUnit);
    on<UpdateHeight>(_updateHeight);
    on<UpdateWeight>(_updateWeight);
    on<UpdateAge>(_updateAge);
    on<UpdateGlobalKey>(_updateGlobalKey);
  }

  void _updateGlobalKey(UpdateGlobalKey event, StateEmitter emit) {
    emit(state.copyWith(key: event.key));
  }

  void _updateGender(UpdateGender event, StateEmitter emit) {
    emit(state.copyWith(gender: event.gender));
  }

  void _updateHeightUnit(UpdateHeightUnit event, StateEmitter emit) {
    emit(state.copyWith(heightUnit: event.height));
  }

  void _updateWeightUnit(UpdateWeightUnit event, StateEmitter emit) {
    emit(state.copyWith(weightUnit: event.weight));
  }

  void _updateWeight(UpdateWeight event, StateEmitter emit) {
    emit(state.copyWith(weight: event.value));
  }

  void _updateHeight(UpdateHeight event, StateEmitter emit) {
    emit(state.copyWith(height: event.value));
  }

  void _updateAge(UpdateAge event, StateEmitter emit) {
    emit(state.copyWith(age: event.age));
  }
}
