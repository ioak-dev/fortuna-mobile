import 'package:endurance/dashboard/login_page.dart';
import 'package:endurance/preset/preset_list/preset_list_page.dart';
import 'package:endurance/dashboard/dashboard_page.dart';
import 'package:endurance/theme/Settings_page.dart';
import 'package:flutter/material.dart';
import 'package:endurance/timer/timer_page.dart';
import 'package:endurance/expnses/Expenses_page.dart';

import '../total_summary.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title, required this.username}) : super(key: key);
  final String title;
  final String username;

  @override
  State<HomePage> createState() => _HomePageState();
}
//
// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;
//   late final List<Widget> screens;
//   @override
//   void initState() {
//     super.initState();
//     screens = [
//     DashboardPage(username: widget.username),
//     const PresetListPage(),
//     TimerPage(),
//     SettingsPage(),
//     LoginPage(),
//     const Center(child: Text('Perform preset')),
//     const Center(child: Text('Settings')),
//   ];
//
//   void _incrementCounter(index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
//
//   openPage(String routeName) {
//     Navigator.pushNamed(context, routeName);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: IndexedStack(index: _currentIndex, children: screens),
//         bottomNavigationBar: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           currentIndex: _currentIndex,
//           onTap: (index) => _incrementCounter(index),
//           // iconSize: 40,
//           showSelectedLabels: true,
//           showUnselectedLabels: false,
//           items: const [
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.graphic_eq), label: 'Feed'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.list), label: 'Preset list'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.timer_outlined), label: 'Timer'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.settings), label: 'Settings')
//           ],
//
//           // child: Row(
//           //   mainAxisSize: MainAxisSize.max,
//           //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //   children: <Widget>[
//           //     IconButton(
//           //         onPressed: () {
//           //           openPage('/dashboard');
//           //         },
//           //         icon: Icon(Icons.list)),
//           //     IconButton(
//           //         onPressed: () {
//           //           openPage('/preset');
//           //         },
//           //         icon: Icon(Icons.directions_walk)),
//           //     IconButton(onPressed: () {}, icon: Icon(Icons.add)),
//           //     IconButton(onPressed: () {}, icon: Icon(Icons.settings_outlined))
//           //   ],
//         ));
//
//   }
// }
class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      DashboardPage(username: widget.username),
      const PresetListPage(),
      TimerPage(),
      SettingsPage(),
      ExpensesPage(username: widget.username),
      ExpenseEntryPage(),
      LoginPage(),
      const Center(child: Text('Perform preset')),
      const Center(child: Text('Settings')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) => _incrementCounter(index),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.graphic_eq),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Preset list',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer_outlined),
            label: 'Timer',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Expenses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet_outlined),
            label: 'Expense',
          ),

        ],
      ),
    );
  }

  void _incrementCounter(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}


