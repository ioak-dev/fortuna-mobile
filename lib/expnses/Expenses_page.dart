import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(ExpensesPage(username: 'username'));
}

class Expenses {
  final String title;
  final double amount;
  final String categoryLabel;
  final Color categoryColor;

  Expenses(this.title, this.amount, this.categoryLabel, this.categoryColor);
}

class ExpensesPage extends StatefulWidget {
  final String username;

  ExpensesPage({required this.username});

  @override
  _ExpensePageAppState createState() => _ExpensePageAppState();
}

class _ExpensePageAppState extends State<ExpensesPage> {
  final List<Expenses> _expenses = [];

  void _addExpense(String title, double amount, String categoryLabel, Color categoryColor) {
    setState(() {
      _expenses.add(Expenses(title, amount, categoryLabel, categoryColor));
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

  Widget _buildCategoryButton(String categoryName, Color categoryColor) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            TextEditingController titleController = TextEditingController();
            TextEditingController amountController = TextEditingController();

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
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                    double amount = double.tryParse(amountController.text) ?? 0.0;

                    if (title.isNotEmpty && amount > 0) {
                      _addExpense(title, amount, categoryName, categoryColor);
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
      child: Text('Add Expense to $categoryName'),
      style: ElevatedButton.styleFrom(primary: categoryColor),
    );
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
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCategoryButton('Food', Colors.green),
                // _buildCategoryButton('Miscellaneous', Colors.orange),
              ],
            ),
            // SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // _buildCategoryButton('Food', Colors.green),
                _buildCategoryButton('Miscellaneous', Colors.orange),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCategoryButton('Entertainment', Colors.purple),
                // _buildCategoryButton('Shopping', Colors.blue),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // _buildCategoryButton('Entertainment', Colors.purple),
                _buildCategoryButton('Shopping', Colors.blue),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Total Items: ${_expenses.length}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Total Cost: \₹${_calculateTotalAmount().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _expenses.length,
                itemBuilder: (context, index) {
                  final expense = _expenses[index];
                  return ListTile(
                    title: Text(expense.title),
                    subtitle: Text('\₹${expense.amount.toStringAsFixed(2)}'),
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
      ),
    );
  }
}
