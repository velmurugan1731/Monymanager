import 'package:flutter/material.dart';
import '../models/transaction.dart';

class AppState extends ChangeNotifier {
  final List<TransactionItem> _transactions = [];
  final String accountName = 'Personal Account';
  final String accountType = 'Cash';

  // Starting balance, mirrors the mockup. Adjusted as transactions are added.
  double _startingBalance = 1000;

  AppState() {
    _seed();
  }

  void _seed() {
    final now = DateTime.now();
    _transactions.addAll([
      TransactionItem(
        id: 't1',
        title: 'Salary',
        category: 'Income',
        amount: 650,
        type: TxType.income,
        date: DateTime(now.year, now.month, now.day, 9, 0),
        icon: Icons.account_balance_wallet,
      ),
      TransactionItem(
        id: 't2',
        title: 'Groceries',
        category: 'Groceries',
        amount: 120,
        type: TxType.expense,
        date: DateTime(now.year, now.month, now.day, 10, 30),
        icon: Icons.shopping_bag,
      ),
      TransactionItem(
        id: 't3',
        title: 'Lunch',
        category: 'Food',
        amount: 80,
        type: TxType.expense,
        date: DateTime(now.year, now.month, now.day, 13, 15),
        icon: Icons.restaurant,
      ),
      TransactionItem(
        id: 't4',
        title: 'Transport',
        category: 'Transport',
        amount: 50,
        type: TxType.expense,
        date: DateTime(now.year, now.month, now.day, 18, 45),
        icon: Icons.directions_car,
      ),
      TransactionItem(
        id: 't5',
        title: 'Movie',
        category: 'Entertainment',
        amount: 100,
        type: TxType.expense,
        date: DateTime(now.year, now.month, now.day - 1, 20, 30),
        icon: Icons.movie,
      ),
      TransactionItem(
        id: 't6',
        title: 'Others',
        category: 'Others',
        amount: 30,
        type: TxType.expense,
        date: DateTime(now.year, now.month, now.day - 2, 12, 0),
        icon: Icons.category,
      ),
    ]);
  }

  List<TransactionItem> get transactions {
    final list = List<TransactionItem>.from(_transactions);
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  double get totalBalance => _startingBalance;

  void addTransaction(TransactionItem t) {
    _transactions.add(t);
    _startingBalance += t.isIncome ? t.amount : -t.amount;
    notifyListeners();
  }

  bool _isToday(DateTime d) {
    final now = DateTime.now();
    return d.year == now.year && d.month == now.month && d.day == now.day;
  }

  double get todayIncome => _transactions
      .where((t) => t.isIncome && _isToday(t.date))
      .fold(0.0, (s, t) => s + t.amount);

  double get todayExpense => _transactions
      .where((t) => !t.isIncome && _isToday(t.date))
      .fold(0.0, (s, t) => s + t.amount);

  double get monthIncome {
    final now = DateTime.now();
    return _transactions
        .where((t) =>
            t.isIncome && t.date.year == now.year && t.date.month == now.month)
        .fold(0.0, (s, t) => s + t.amount);
  }

  double get monthExpense {
    final now = DateTime.now();
    return _transactions
        .where((t) =>
            !t.isIncome && t.date.year == now.year && t.date.month == now.month)
        .fold(0.0, (s, t) => s + t.amount);
  }

  Map<String, double> get monthExpenseByCategory {
    final now = DateTime.now();
    final Map<String, double> map = {};
    for (final t in _transactions) {
      if (!t.isIncome && t.date.year == now.year && t.date.month == now.month) {
        map[t.category] = (map[t.category] ?? 0) + t.amount;
      }
    }
    return map;
  }
}
