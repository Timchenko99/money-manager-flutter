import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Transaction extends Equatable {

  final String id;
  final String title;
  final DateTime date;
  final double amount;
  final IconData icon;

  Transaction(
      {@required this.id, @required this.title, @required this.date, @required this.amount, @required this.icon});

  @override
  List<Object> get props => [id, title, date, amount, icon];
}
