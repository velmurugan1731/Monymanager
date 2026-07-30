import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/transaction_tile.dart';

class HistoryScreen extends StatefulWidget {
  final AppState appState;
  const HistoryScreen({super.key, required this.appState});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  TxType filterType = TxType.expense;
  String period = 'Today';

  final periods = const ['Today', '7 days', '1 month', '3 month', '6 month', '1 year'];

  DateTime? _cutoff() {
    final now = DateTime.now();
    switch (period) {
      case 'Today':
        return DateTime(now.year, now.month, now.day);
      case '7 days':
        return now.subtract(const Duration(days: 7));
      case '1 month':
        return DateTime(now.year, now.month - 1, now.day);
      case '3 month':
        return DateTime(now.year, now.month - 3, now.day);
      case '6 month':
        return DateTime(now.year, now.month - 6, now.day);
      case '1 year':
        return DateTime(now.year - 1, now.month, now.day);
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cutoff = _cutoff();
    final filtered = widget.appState.transactions.where((t) {
      final matchesType = t.type == filterType;
      final matchesDate = cutoff == null || !t.date.isBefore(cutoff);
      return matchesType && matchesDate;
    }).toList();
    final total = filtered.fold(0.0, (s, t) => s + t.amount);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                  ),
                  const Expanded(
                    child: Text('History', textAlign: TextAlign.center, style: AppTextStyles.heading),
                  ),
                  const Icon(Icons.filter_list_rounded),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _ToggleButton(
                      label: 'Expense',
                      selected: filterType == TxType.expense,
                      onTap: () => setState(() => filterType = TxType.expense),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _ToggleButton(
                      label: 'Income',
                      selected: filterType == TxType.income,
                      onTap: () => setState(() => filterType = TxType.income),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final chosen = await showModalBottomSheet<String>(
                        context: context,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                        builder: (ctx) => SafeArea(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: periods
                                .map((p) => ListTile(title: Text(p), onTap: () => Navigator.pop(ctx, p)))
                                .toList(),
                          ),
                        ),
                      );
                      if (chosen != null) setState(() => period = chosen);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.divider),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today_outlined, size: 16),
                          const SizedBox(width: 8),
                          Text(period, style: AppTextStyles.body),
                          const Icon(Icons.keyboard_arrow_down_rounded),
                        ],
                      ),
                    ),
                  ),
                  Text('Total: \u20B9${total.toStringAsFixed(0)}', style: AppTextStyles.body),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: filtered.isEmpty
                    ? Center(child: Text('No transactions for this period', style: AppTextStyles.subtitle))
                    : ListView.separated(
                        itemCount: filtered.length,
                        separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.divider),
                        itemBuilder: (_, i) => TransactionTile(tx: filtered[i]),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ToggleButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ToggleButton({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.white,
          border: Border.all(color: selected ? AppColors.primary : AppColors.divider),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(color: selected ? Colors.white : AppColors.textPrimary, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
