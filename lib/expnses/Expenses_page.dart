import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';

import '../theme/ThemeManager.dart';

void main() {
  runApp(ExpensesPage(username: 'username'));
}

class Expenses {
  final String title;
  final double amount;
  final String categoryLabel;
  final Color categoryColor;
  final IconData categoryIcon;

  Expenses(this.title, this.amount, this.categoryLabel, this.categoryColor, this.categoryIcon);
}

class ExpensesPage extends StatefulWidget {
  final String username;

  ExpensesPage({required this.username});

  @override
  _ExpensePageAppState createState() => _ExpensePageAppState();
}

class _ExpensePageAppState extends State<ExpensesPage> {
  final List<Expenses> _expenses = [];

  void _addExpense(String title, double amount, String categoryLabel, Color categoryColor, IconData categoryIcon) {
    setState(() {
      _expenses.add(Expenses(title, amount, categoryLabel, categoryColor, categoryIcon));
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

  Widget _buildCategoryButton(String categoryName, Color categoryColor, IconData categoryIcon) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                TextEditingController titleController = TextEditingController();
                TextEditingController amountController = TextEditingController();

                return AlertDialog(
                  title: Text('Add Expense'),
                  content: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Column(
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
                          _addExpense(title, amount, categoryName, categoryColor, categoryIcon);
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
          icon: Icon(categoryIcon),
          label: Text('$categoryName'),
          style: ElevatedButton.styleFrom(primary: categoryColor),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeManager>(context).themeData,
      title: 'Expense Tracker',
      home: Scaffold(
          resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Expense Tracker'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 7),
            Container(
              alignment: Alignment.center,
              child: TyperAnimatedTextKit(
                text: ['Hi, ${widget.username}!'],
                textStyle: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 24,
                ),
                speed: Duration(milliseconds: 300),
                isRepeatingAnimation: false,
              ),
            ),
            SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCategoryButton('Food', Colors.green, Icons.fastfood),
                _buildCategoryButton('Miscellaneous', Colors.orange, Icons.dashboard),
              ],
            ),
            SizedBox(height: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCategoryButton('Entertainment', Colors.purple, Icons.movie),
                _buildCategoryButton('Shopping', Colors.blue, Icons.shopping_cart),
              ],
            ),
            SizedBox(height: 1),
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
                    subtitle: Text('₹${expense.amount.toStringAsFixed(2)}'),
                    leading: Container(
                      width: 10,
                      height: 30,
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


// void main() {
//   runApp(MaterialApp(home: Scaffold(body: ExpensesPage(username: 'Test'))));
// }
