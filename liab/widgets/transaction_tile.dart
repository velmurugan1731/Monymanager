import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import '../theme.dart';

class TransactionTile extends StatelessWidget {
  final TransactionItem tx;

  const TransactionTile({super.key, required this.tx});

  @override
  Widget build(BuildContext context) {
    final isIncome = tx.isIncome;
    final circleColor = isIncome ? AppColors.incomeBg : AppColors.expenseBg;
    final iconColor = isIncome ? AppColors.income : AppColors.expense;
    final amountColor = isIncome ? AppColors.income : AppColors.expense;
    final sign = isIncome ? '+' : '-';
    final timeStr = DateFormat('h:mm a').format(tx.date);
    final dateLabel = _relativeDay(tx.date);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: circleColor,
            child: Icon(tx.icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tx.title, style: AppTextStyles.body),
                const SizedBox(height: 2),
                Text('$dateLabel, $timeStr', style: AppTextStyles.subtitle),
              ],
            ),
          ),
          Text(
            '$sign\u20B9${tx.amount.toStringAsFixed(0)}',
            style: TextStyle(color: amountColor, fontWeight: FontWeight.w700, fontSize: 15),
          ),
        ],
      ),
    );
  }

  String _relativeDay(DateTime d) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final that = DateTime(d.year, d.month, d.day);
    final diff = today.difference(that).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    return DateFormat('MMM d').format(d);
  }
}
