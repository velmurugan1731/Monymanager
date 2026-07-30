import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/add_transaction_sheet.dart';
import '../widgets/sparkline_chart.dart';

class DashboardScreen extends StatelessWidget {
  final AppState appState;
  const DashboardScreen({super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Dashboard', style: AppTextStyles.heading),
                const Icon(Icons.more_vert_rounded),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Balance Overview', style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 8),
                  Text('\u20B9${appState.totalBalance.toStringAsFixed(0)}', style: AppTextStyles.amountLarge),
                  const Text('Total Balance', style: TextStyle(color: Colors.white70, fontSize: 13)),
                  const SizedBox(height: 12),
                  const SparklineChart(values: [400, 700, 550, 850, 650, 950, 1000]),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Text('This Month', style: TextStyle(color: Colors.white)),
                      Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white, size: 18),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Quick Actions', style: AppTextStyles.body),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _QuickAction(
                    label: 'Add Income',
                    icon: Icons.arrow_downward_rounded,
                    color: AppColors.income,
                    onTap: () => showAddTransactionSheet(context, appState, TxType.income),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _QuickAction(
                    label: 'Add Expense',
                    icon: Icons.arrow_upward_rounded,
                    color: AppColors.expense,
                    onTap: () => showAddTransactionSheet(context, appState, TxType.expense),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Accounts', style: AppTextStyles.body),
                Text('View All', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.divider),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.account_balance_wallet_rounded, color: AppColors.primary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(appState.accountName, style: AppTextStyles.body),
                        Text(appState.accountType, style: AppTextStyles.subtitle),
                      ],
                    ),
                  ),
                  Text('\u20B9${appState.totalBalance.toStringAsFixed(0)}',
                      style: const TextStyle(color: AppColors.income, fontWeight: FontWeight.w700)),
                  const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickAction({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.divider),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(radius: 14, backgroundColor: color, child: Icon(icon, color: Colors.white, size: 14)),
            const SizedBox(width: 8),
            Flexible(child: Text(label, style: AppTextStyles.body, overflow: TextOverflow.ellipsis)),
          ],
        ),
      ),
    );
  }
}
