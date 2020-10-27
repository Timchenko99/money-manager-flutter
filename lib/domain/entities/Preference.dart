import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Preference extends Equatable {
  final bool isFirstBoot;
  final double targetedAmount;
  final double dailyBudget;
  final String goal;

  Preference(
      {@required this.isFirstBoot,@required this.targetedAmount,@required this.dailyBudget,@required this.goal});

  @override
  List<Object> get props => [isFirstBoot, targetedAmount, dailyBudget, goal];

}

// class Preference<Type> extends Equatable{
//   final String key;
//   final Type value;
//
//   Preference({this.key, this.value});
//
//   @override
//   List<Object> get props => [key, value];
// }