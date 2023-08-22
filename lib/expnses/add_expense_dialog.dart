import 'package:flutter/material.dart';

class AddExpenseDialog extends StatefulWidget {
  final String categoryName;
  final Color categoryColor;
  final IconData categoryIcon;

  AddExpenseDialog({
    required this.categoryName,
    required this.categoryColor,
    required this.categoryIcon,
  });

  @override
  _AddExpenseDialogState createState() => _AddExpenseDialogState();
}

class _AddExpenseDialogState extends State<AddExpenseDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: AlertDialog(
            title: Text('Add Expense'),
            content: SingleChildScrollView(
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

                    label:  DefaultTextStyle(
                    style: TextStyle(color: Colors.black),
                    child: Text('Select Date'),
                  ),
                  ),
                ],

              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
          child: DefaultTextStyle(
            style: TextStyle(color: Colors.black),
            child: Text('Cancel'),
          ),
              ),
              TextButton(
                onPressed: () {
                  String title = titleController.text;
                  double amount =
                      double.tryParse(amountController.text) ?? 0.0;
                  String description = descriptionController.text;

                  if (title.isNotEmpty && amount > 0) {
                    Navigator.of(context).pop({
                      'title': title,
                      'amount': amount,
                      'description': descriptionController.text,
                      'selectedDate': selectedDate,
                    });
                  }
                },
                child: DefaultTextStyle(
                  style: TextStyle(color: Colors.black), // Set text color here
                  child: Text('Add'),
                ),
              ),
            ],
            backgroundColor: widget.categoryColor,
          ),
        );
      },
    );
  }
}
