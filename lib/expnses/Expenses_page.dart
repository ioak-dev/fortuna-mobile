import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Expenso/expnses/add_expense_dialog.dart';

import 'category_icons.dart';

class Expenses {
  final double amount;
  final String description;
  final DateTime selectedDate;
  final String notes;
  final String tags;
  final CategoryIcon category;

  Expenses({
    required this.amount,
    required this.tags,
    required this.notes,
    required this.selectedDate,
    required this.description,
    required this.category,
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
    setState(() {
      _expenses.add(Expenses(
        amount: result['amount'],
        description: result['description'],
        selectedDate: result['selectedDate'],
        notes: result['notes'],
        tags: result['tags'],
        category: result['category'],
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
    return DefaultTabController(
      length: 1,
      child: Scaffold(
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
          title: Text(
            'Hi, ${widget.username}',
            style: const TextStyle(color: Colors.lightBlueAccent),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_alt_sharp),
              onPressed: () => 0,
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total spent',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '₹${_calculateTotalAmount().toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Total income',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '₹0',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey.shade300,
              child: const TabBar(
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                tabs: [
                  Tab(
                    child: Text('Transactions'),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(height: 8),
                itemCount: _expenses.length,
                itemBuilder: (context, index) {
                  final expense = _expenses[index];
                  return ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            expense.category.icon,
                            color: expense.category.color,
                          ),
                        )
                      ],
                    ),
                    title: Text(expense.description),
                    subtitle: Row(
                      children: [
                        if (expense.tags.isNotEmpty)
                          Text(
                            expense.tags,
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        Text(
                          expense.notes,
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 12),
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              DateFormat("dd MMM ''yy")
                                  .format(expense.selectedDate),
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            const Icon(
                              Icons.arrow_outward_rounded,
                              color: Colors.black,
                            )
                          ],
                        ),
                        Text(
                          NumberFormat.currency(locale: 'HI', symbol: '₹')
                              .format(expense.amount),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
