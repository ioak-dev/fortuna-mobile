import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:intl/intl.dart';
import 'package:endurance/expnses/add_expense_dialog.dart';

class Expenses {
  final double amount;
  final String description;
  final DateTime selectedDate;
  final String notes;
  final String tags;

  Expenses(
      {required this.amount,
      required this.tags,
      required this.notes,
      required this.selectedDate,
      required this.description});
}

class ExpensesPage extends StatefulWidget {
  final String username;

  ExpensesPage({required this.username});

  @override
  _ExpensePageAppState createState() => _ExpensePageAppState();
}

class _ExpensePageAppState extends State<ExpensesPage> {
  final List<Expenses> _expenses = [];

  void _addExpense(Map result) {
    setState(() {
      _expenses.add(Expenses(
          amount: result['amount'],
          description: result['description'],
          selectedDate: result['selectedDate'],
          notes: result['notes'],
          tags: result['tags']));
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
              if (result != null) {
                print(result);
                _addExpense(result);
              }
            });
          },
          label: Text('Add Expense')),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // TotalSummary(
          //   totalItems: _expenses.length,
          //   totalCost: _calculateTotalAmount(),
          // ),
          // SizedBox(height: 20),
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
                  title: Text(expense.description),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('₹${expense.amount.toStringAsFixed(2)}'),
                      Text(
                        'Selected Date: ${DateFormat('MMMM dd, yyyy').format(expense.selectedDate)}',
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
                    // color: expense.categoryColor,
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
