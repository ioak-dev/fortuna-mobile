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


void main() {
  runApp(ExpensesApp());
}

class Expenses {
  final String title;
  final double amount;
  final String categoryLabel;
  final Color categoryColor;
  final IconData categoryIcon;
  final DateTime expenseDate;
  final String description;

  Expenses(this.title, this.amount, this.categoryLabel, this.categoryColor, this.categoryIcon, this.expenseDate, this.description);
}

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExpensesPage(username: 'username'),
    );
  }
}

class ExpensesPage extends StatefulWidget {
  final String username;

  ExpensesPage({required this.username});

  @override
  _ExpensePageAppState createState() => _ExpensePageAppState();
}

class _ExpensePageAppState extends State<ExpensesPage> {
  final List<Expenses> _expenses = [];

  void _addExpense(
      String title,
      double amount,
      String categoryLabel,
      Color categoryColor,
      IconData categoryIcon,
      DateTime expenseDate,
      {String description = ''}
      ) {
    setState(() {
      _expenses.add(
        Expenses(title, amount, categoryLabel, categoryColor, categoryIcon, expenseDate, description),
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

  // Widget _buildCategoryButton(String categoryName, Color categoryColor, IconData categoryIcon) {
  //   DateTime selectedDate = DateTime.now();
  //   return Column(
  //     children: [
  //       ElevatedButton.icon(
  //         onPressed: () {
  //           showDialog(
  //             context: context,
  //             builder: (context) {
  //               TextEditingController titleController = TextEditingController();
  //               TextEditingController amountController = TextEditingController();
  //
  //               return AlertDialog(
  //                 title: Text('Add Expense'),
  //                 content: SingleChildScrollView(
  //                   child: Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       TextField(
  //                         controller: titleController,
  //                         decoration: InputDecoration(labelText: 'Title'),
  //                       ),
  //                       TextField(
  //                         controller: amountController,
  //                         keyboardType: TextInputType.numberWithOptions(decimal: true),
  //                         decoration: InputDecoration(labelText: 'Amount'),
  //                       ),
  //                       TextButton.icon(
  //                         onPressed: () async {
  //                           final pickedDate = await showDatePicker(
  //                             context: context,
  //                             initialDate: selectedDate,
  //                             firstDate: DateTime(2000),
  //                             lastDate: DateTime(2101),
  //                           );
  //
  //                           if (pickedDate != null) {
  //                             setState(() {
  //                               selectedDate = pickedDate;
  //                             });
  //                           }
  //                         },
  //                         icon: Icon(Icons.calendar_today),
  //                         label: Text('Select Date'),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 actions: [
  //                   TextButton(
  //                     onPressed: () {
  //                       Navigator.of(context).pop();
  //                     },
  //                     child: Text('Cancel'),
  //                   ),
  //                   TextButton(
  //                     onPressed: () {
  //                       String title = titleController.text;
  //                       double amount = double.tryParse(amountController.text) ?? 0.0;
  //
  //                       if (title.isNotEmpty && amount > 0) {
  //                         _addExpense(title, amount, categoryName, categoryColor, categoryIcon, selectedDate);
  //                         Navigator.of(context).pop();
  //                       }
  //                     },
  //                     child: Text('Add'),
  //                   ),
  //                 ],
  //               );
  //             },
  //           );
  //         },
  //         icon: Icon(categoryIcon),
  //         label: Text('$categoryName'),
  //         style: ElevatedButton.styleFrom(primary: categoryColor),
  //       ),
  //       SizedBox(height: 10),
  //       // Text(
  //       //   'Selected Date: ${selectedDate.toLocal()}',
  //       //   style: TextStyle(fontSize: 7, color: Colors.grey),
  //       // ),
  //     ],
  //   );
  // }
  Widget _buildCategoryButton(String categoryName, Color categoryColor, IconData categoryIcon) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AddExpenseDialog(
                  categoryName: categoryName,
                  categoryColor: categoryColor,
                  categoryIcon: categoryIcon,
                );
              },
            ).then((result) {
              if (result != null) {
                _addExpense(
                  result['title'],
                  result['amount'],
                  categoryName,
                  categoryColor,
                  categoryIcon,
                  result['selectedDate'],
                  description: result['description'],
                );
              }
            });
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
    return Scaffold(
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
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCategoryButton('Food', Colors.green, Icons.fastfood),
              _buildCategoryButton('Miscellaneous', Colors.orange, Icons.dashboard),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCategoryButton('Entertainment', Colors.purple, Icons.movie),
              _buildCategoryButton('Shopping', Colors.blue, Icons.shopping_cart),
            ],
          ),
          SizedBox(height: 10),
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
                        style: TextStyle(fontSize: 14, color: Colors.lightBlueAccent),
                      ),
                      if (expense.description.isNotEmpty) // Only display if description is not empty
                        Text(
                          'Description: ${expense.description}',
                          style: TextStyle(fontSize: 14, color: Colors.tealAccent),
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