import 'package:flutter/material.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/bottom_nav_bar.dart';
import 'dashboard_screen.dart';
import 'home_screen.dart';
import 'report_screen.dart';

class MainNavigation extends StatefulWidget {
  final AppState appState;
  const MainNavigation({super.key, required this.appState});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(appState: widget.appState),
      ReportScreen(appState: widget.appState),
      DashboardScreen(appState: widget.appState),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(index: index, children: screens),
      bottomNavigationBar: BottomNavBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
      ),
    );
  }
}
