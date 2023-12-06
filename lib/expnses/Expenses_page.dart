import 'dart:math';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:intl/intl.dart';
import 'package:Expenso/expnses/add_expense_dialog.dart';

import 'category_icons.dart';

class Expenses {
  final double amount;
  final String description;
  final DateTime selectedDate;
  final String notes;
  final String tags;
  final List<String> categories;

  Expenses({
    required this.amount,
    required this.tags,
    required this.notes,
    required this.selectedDate,
    required this.description,
    this.categories = const [],
  });
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
    List<String> categories = [];

    (result['category'] as List<CategoryIcon>).forEach((CategoryIcon element) {
      categories.add(element.label);
    });

    setState(() {
      _expenses.add(Expenses(
        amount: result['amount'],
        description: result['description'],
        selectedDate: result['selectedDate'],
        notes: result['notes'],
        tags: result['tags'],
        categories: categories,
      ));
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
        label: const Icon(Icons.add, size: 25),
      ),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            child: TyperAnimatedTextKit(
              text: ['Hi, ${widget.username}!'],
              textStyle: const TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              speed: Duration(milliseconds: 100),
              isRepeatingAnimation: false,
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              'Total Items: ${_expenses.length}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              'Total Cost: ₹${_calculateTotalAmount().toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _expenses.length,
              itemBuilder: (context, index) {
                final expense = _expenses[index];
                return Card(
                  color: Colors.blueGrey.shade50,
                  elevation: 3,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(
                      '${index + 1}. ${expense.description}',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey.shade900),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Spent: ₹${expense.amount.toStringAsFixed(2)}',
                          style:
                              TextStyle(fontSize: 14, color: Colors.lightGreen),
                        ),
                        Text(
                          DateFormat('MMMM dd, yyyy')
                              .format(expense.selectedDate),
                          style: TextStyle(
                              fontSize: 14, color: Colors.blueAccent.shade700),
                        ),
                        if (expense.categories.isNotEmpty)
                          Text(expense.categories.toString()),
                        if (expense.description.isNotEmpty)
                          Text(
                            'Description: ${expense.description}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.blueGrey),
                          ),
                      ],
                    ),
                    leading: const Icon(Icons.arrow_right,
                        color: Colors.blue, size: 40),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _removeExpenses(index);
                      },
                    ),
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
