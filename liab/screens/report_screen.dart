import 'package:flutter/material.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/donut_chart.dart';

class ReportScreen extends StatelessWidget {
  final AppState appState;
  const ReportScreen({super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    final byCategory = appState.monthExpenseByCategory;
    final total = byCategory.values.fold(0.0, (a, b) => a + b);
    final entries = byCategory.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    final data = <DonutChartData>[];
    for (int i = 0; i < entries.length; i++) {
      data.add(DonutChartData(
        label: entries[i].key,
        value: entries[i].value,
        color: AppColors.categoryColors[i % AppColors.categoryColors.length],
      ));
    }

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Report', style: AppTextStyles.heading),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle),
                  child: const Icon(Icons.calendar_today_outlined, size: 18),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.divider),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('This Month', style: AppTextStyles.body),
                  Icon(Icons.keyboard_arrow_down_rounded),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.divider),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Expense Overview', style: AppTextStyles.body),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DonutChart(data: data, total: total, centerLabel: 'Total'),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          children: data
                              .map((d) => Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(color: d.color, shape: BoxShape.circle),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(child: Text(d.label, style: AppTextStyles.subtitle)),
                                        Text('\u20B9${d.value.toStringAsFixed(0)}', style: AppTextStyles.body),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.divider),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Summary', style: AppTextStyles.body),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(14)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Total Income', style: AppTextStyles.subtitle),
                              const SizedBox(height: 4),
                              Text(
                                '\u20B9${appState.monthIncome.toStringAsFixed(0)}',
                                style: const TextStyle(color: AppColors.income, fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(14)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Total Expense', style: AppTextStyles.subtitle),
                              const SizedBox(height: 4),
                              Text(
                                '\u20B9${appState.monthExpense.toStringAsFixed(0)}',
                                style: const TextStyle(color: AppColors.expense, fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
