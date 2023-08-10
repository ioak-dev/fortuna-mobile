import 'package:flutter/material.dart';

void main() {
  runApp(ExpensesPage());
}

class Expenses {
  final String title;
  final double amount;

  Expenses(this.title, this.amount);
}

class ExpensesPage extends StatefulWidget {
  @override
  _ExpensePageAppState createState() => _ExpensePageAppState();
}

class _ExpensePageAppState extends State<ExpensesPage> {
  final List<Expenses> _expenses = [];

  void _addExpense(String title, double amount) {
    setState(() {
      _expenses.add(Expenses(title, amount));
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
    return MaterialApp(
      title: 'Expense Tracker',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Expense Tracker'),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    TextEditingController titleController =
                    TextEditingController();
                    TextEditingController amountController =
                    TextEditingController();

                    return AlertDialog(
                      title: Text('Add Expense'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: titleController,
                            decoration: InputDecoration(labelText: 'Title'),
                          ),
                          TextField(
                            controller: amountController,
                            keyboardType: TextInputType.numberWithOptions(
                                decimal: true),
                            decoration: InputDecoration(labelText: 'Amount'),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            String title = titleController.text;
                            double amount =
                                double.tryParse(amountController.text) ?? 0.0;

                            if (title.isNotEmpty && amount > 0) {
                              _addExpense(title, amount);
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text('Add'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Add Expense'),
            ),
            SizedBox(height: 10),
            Text(
              'Total Items: ${_expenses.length}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Total Cost: \$${_calculateTotalAmount().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _expenses.length,
                itemBuilder: (context, index) {
                  final expense = _expenses[index];
                  return ListTile(
                    title: Text(expense.title),
                    subtitle: Text('\$${expense.amount.toStringAsFixed(2)}'),
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
      ),
    );
  }
}
