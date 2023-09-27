import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';

import '../theme/ThemeManager.dart';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:endurance/expnses/add_expense_dialog.dart';
import '../total_summary.dart';
import 'add_expense_dialog.dart';

class Expenses {
  final String title;
  final double amount;
  final String categoryLabel;
  final Color categoryColor;
  final IconData categoryIcon;
  final DateTime expenseDate;
  final String description;

  Expenses(this.title, this.amount, this.categoryLabel, this.categoryColor,
      this.categoryIcon, this.expenseDate, this.description);
}

class ExpensesPage extends StatefulWidget {
  final String username;

  ExpensesPage({required this.username});

  @override
  _ExpensePageAppState createState() => _ExpensePageAppState();
}

class _ExpensePageAppState extends State<ExpensesPage> {
  final List<Expenses> _expenses = [];

  void _addExpense(String title, double amount, String categoryLabel,
      Color categoryColor, IconData categoryIcon, DateTime expenseDate,
      {String description = ''}) {
    setState(() {
      _expenses.add(
        Expenses(title, amount, categoryLabel, categoryColor, categoryIcon,
            expenseDate, description),
      );
    });
  }

  void _removeExpenses(int index) {
    setState(() {
      _expenses.removeAt(index);
    });
  }

  double _calculateTotalAmount() {
    double total = 0;
    for (var expense in _expenses) {
      total += expense.amount;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AddExpenseDialog();
              },
            ).then((result) {
              if (result != null)
              { print(result);
                _addExpense(
                  result['title'],
                  result['amount'],
                  result['categoryName'],
                  result['categoryColor'],
                  result['categoryIcon'],
                  result['selectedDate'],
                  description: result['description'],
                );
              }
            });
          },
          label: Text('Add Expense')),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // TotalSummary(
          //   totalItems: _expenses.length,
          //   totalCost: _calculateTotalAmount(),
          // ),
          SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            child: TyperAnimatedTextKit(
              text: ['Hi, ${widget.username}!'],
              textStyle: TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 24,
              ),
              speed: Duration(milliseconds: 100),
              isRepeatingAnimation: false,
            ),
          ),
          Center(
            child: Text(
              'Total Items: ${_expenses.length}',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Center(
            child: Text(
              'Total Cost: ₹${_calculateTotalAmount().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _expenses.length,
              itemBuilder: (context, index) {
                final expense = _expenses[index];
                return ListTile(
                  title: Text(expense.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('₹${expense.amount.toStringAsFixed(2)}'),
                      Text(
                        'Selected Date: ${DateFormat('MMMM dd, yyyy').format(expense.expenseDate)}',
                        style: TextStyle(
                            fontSize: 14, color: Colors.lightBlueAccent),
                      ),
                      if (expense.description
                          .isNotEmpty) // Only display if description is not empty
                        Text(
                          'Description: ${expense.description}',
                          style:
                          TextStyle(fontSize: 14, color: Colors.tealAccent),
                        ),
                    ],
                  ),
                  leading: Container(
                    width: 10,
                    height: 40,
                    color: expense.categoryColor,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _removeExpenses(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
