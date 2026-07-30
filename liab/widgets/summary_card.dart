import 'package:flutter/material.dart';
import '../theme.dart';

class SummaryCard extends StatelessWidget {
  final String label;
  final double amount;
  final bool isIncome;

  const SummaryCard({
    super.key,
    required this.label,
    required this.amount,
    required this.isIncome,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isIncome ? AppColors.incomeBg : AppColors.expenseBg;
    final iconBg = isIncome ? AppColors.income : AppColors.expense;
    final icon = isIncome ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            CircleAvatar(radius: 16, backgroundColor: iconBg, child: Icon(icon, color: Colors.white, size: 16)),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppTextStyles.subtitle),
                  Text('\u20B9${amount.toStringAsFixed(0)}', style: AppTextStyles.body),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
