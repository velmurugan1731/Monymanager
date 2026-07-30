import 'package:flutter/material.dart';

enum TxType { income, expense }

class TransactionItem {
  final String id;
  final String title;
  final String category;
  final double amount;
  final TxType type;
  final DateTime date;
  final IconData icon;

  TransactionItem({
    required this.id,
    required this.title,
    required this.category,
    required this.amount,
    required this.type,
    required this.date,
    required this.icon,
  });

  bool get isIncome => type == TxType.income;
}
