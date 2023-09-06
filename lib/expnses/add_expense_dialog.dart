import 'dart:ffi';

import 'package:flutter/material.dart';

import 'Expenses_page.dart';

class AddExpenseDialog extends StatefulWidget {
  final String? categoryName;
  final Color? categoryColor;
  final IconData? categoryIcon;

  AddExpenseDialog({
    this.categoryName,
    this.categoryColor,
    this.categoryIcon,
  });

  @override
  _AddExpenseDialogState createState() => _AddExpenseDialogState();
}

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

class _AddExpenseDialogState extends State<AddExpenseDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String? categoryName;
  IconData? categoryIcon;
  Color? categoryColor;

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    titleController.dispose();
    amountController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  Widget _buildCategoryButton(
      String categoryName, Color categoryColor, IconData categoryIcon) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              this.categoryName = categoryName;
              this.categoryIcon = categoryIcon;
              this.categoryColor = categoryColor;
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

  void sendData(
      String? categoryName, Color? categoryColor, IconData? categoryIcon) {
    if (hasData(
        titleController.text,
        double.tryParse(amountController.text) ?? 0.0,
        categoryName,
        categoryColor)) {
      Navigator.of(context).pop({
        'title': titleController.text,
        'amount':  double.parse(amountController.text),
        'categoryName': categoryName,
        'categoryColor': categoryColor,
        'categoryIcon': categoryIcon,
        'description': descriptionController.text,
        'selectedDate': selectedDate,
      });
    }
  }

  bool hasData(String title, double amount, String? categoryName,
      Color? categoryColor) =>
      title.isNotEmpty &&
          amount > 0 &&
          categoryColor != null &&
          categoryName != null;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: Dialog.fullscreen(
            // insetPadding: EdgeInsets.all(0),
            // title: Text('Add Expense'),
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () =>
                      sendData(categoryName, categoryColor, categoryIcon),
                  icon: Icon(Icons.close),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(labelText: 'Title'),
                    ),
                    TextField(
                      controller: amountController,
                      keyboardType:
                      TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(labelText: 'Amount'),
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(labelText: 'Description'),
                    ),
                    // TextField(
                    //   controller: descriptionController, // Add this line
                    //   decoration: InputDecoration(labelText: 'Description'),
                    // ),
                    TextButton.icon(
                      onPressed: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );

                        if (pickedDate != null) {
                          selectedDate = pickedDate;
                        }
                      },
                      icon: Icon(Icons.calendar_today),
                      label: DefaultTextStyle(
                        style: TextStyle(color: Colors.black),
                        child: Text('Select Date'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCategoryButton(
                            'Food', Colors.green, Icons.fastfood),
                        _buildCategoryButton(
                            'Miscellaneous', Colors.orange, Icons.dashboard),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCategoryButton(
                            'Entertainment', Colors.purple, Icons.movie),
                        _buildCategoryButton(
                            'Shopping', Colors.blue, Icons.shopping_cart),
                      ],
                    ),
                    // SizedBox(height: 1),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildCategoryButton(
                              'Add New', Colors.lightBlueAccent, Icons.add),
                          _buildCategoryButton('Medical', Colors.green,
                              Icons.medical_information),
                        ]),
                  ],
                ),
              ),
            ),

            // backgroundColor: widget.categoryColor,
          ),
        );
      },
    );
  }
}

// actions: [
//     TextButton(
//       onPressed: () {
//         Navigator.of(context).pop();
//       },
// child: DefaultTextStyle(
//   style: TextStyle(color: Colors.black),
//   child: Text('Cancel'),
// ),
//     ),
//     TextButton(
//       onPressed: () {
//         String title = titleController.text;
//         double amount =
//             double.tryParse(amountController.text) ?? 0.0;
//         String description = descriptionController.text;
//
//         if (title.isNotEmpty && amount > 0) {
//           Navigator.of(context).pop({
//             'title': title,
//             'amount': amount,
//             'description': descriptionController.text,
//             'selectedDate': selectedDate,
//           });
//         }
//       },
//       child: DefaultTextStyle(
//         style: TextStyle(color: Colors.black), // Set text color here
//         child: Text('Add'),
//       ),
//     ),
//   ],