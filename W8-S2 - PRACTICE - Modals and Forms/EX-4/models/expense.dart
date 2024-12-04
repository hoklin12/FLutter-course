import 'package:flutter/material.dart';

enum Device{euro, riel, yuan}

class Expense {
  Expense({
    required this.amount,
    required this.device,
    // this.newAmount,
  });

  final double amount;
  final Device device;
  // final double? newAmount;

  @override
  String toString() {
    return "Amount $amount , device $device";
  }
}
