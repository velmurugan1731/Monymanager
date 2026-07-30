import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../state/app_state.dart';
import '../theme.dart';

Future<void> showAddTransactionSheet(
  BuildContext context,
  AppState appState,
  TxType type,
) {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  String category = type == TxType.income ? 'Income' : 'Groceries';

  final categories = type == TxType.income
      ? ['Income', 'Bonus', 'Gift', 'Other']
      : ['Groceries', 'Food', 'Transport', 'Entertainment', 'Others'];

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (ctx) {
      return Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
        ),
        child: StatefulBuilder(
          builder: (ctx, setSheetState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type == TxType.income ? 'Add Income' : 'Add Expense',
                  style: AppTextStyles.heading,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: amountController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'Amount (\u20B9)', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: category,
                  decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
                  items: categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                  onChanged: (v) => setSheetState(() => category = v ?? category),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: type == TxType.income ? AppColors.income : AppColors.expense,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      final amount = double.tryParse(amountController.text) ?? 0;
                      if (titleController.text.trim().isEmpty || amount <= 0) return;
                      appState.addTransaction(TransactionItem(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: titleController.text.trim(),
                        category: category,
                        amount: amount,
                        type: type,
                        date: DateTime.now(),
                        icon: type == TxType.income ? Icons.account_balance_wallet : Icons.category,
                      ));
                      Navigator.pop(ctx);
                    },
                    child: Text(
                      type == TxType.income ? 'Add Income' : 'Add Expense',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
