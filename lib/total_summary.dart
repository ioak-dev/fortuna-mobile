import 'package:flutter/material.dart';

class ExpenseEntryPage extends StatefulWidget {
  @override
  _ExpenseEntryPageState createState() => _ExpenseEntryPageState();
}

class _ExpenseEntryPageState extends State<ExpenseEntryPage> {
  late DateTime selectedDate;
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Expense Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Amount',
              style: TextStyle(fontSize: 18),
            ),
            TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 16),
            Text(
              'What was this spend for?',
              style: TextStyle(fontSize: 18),
            ),
            TextFormField(
              keyboardType: TextInputType.name,
            ),
            SizedBox(height: 10),
            Text(
              'Select Date',
                  style:TextStyle(fontSize: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    'Select Date: ${selectedDate.toLocal().toString().split(' ')[0]}',
                  ),
                ),
                TextButton(
                  onPressed: () => _selectTime(context),
                  child: Text('Select Time: ${selectedTime.format(context)}'),
                ),
              ],
            ),

            SizedBox(height: 16),
            Text(
              'Categories',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CategoryButton(icon: Icons.fastfood, label: 'Food'),
                CategoryButton(icon: Icons.movie, label: 'Cinema'),
                CategoryButton(icon: Icons.shopping_bag, label: 'Shopping'),
                // Add more buttons for other categories
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CategoryButton(icon: Icons.medical_information, label: 'Medicines'),
                CategoryButton(icon: Icons.sports_soccer_outlined, label: 'Sports'),
                CategoryButton(icon: Icons.add, label: 'Add New'),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Add a Note',
              style: TextStyle(fontSize: 18),
            ),
            TextFormField(
              keyboardType: TextInputType.name,
            ),
            SizedBox(height: 190),
            Text(
              'Save And Add Another',
              style: TextStyle(color: Colors.blue,fontSize: 18),
            )


          ],
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final IconData icon;
  final String label;

  CategoryButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // Add logic to handle button press
        // You can open a dialog or perform any action here
      },
      icon: Icon(icon),
      label: Text(label),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ExpenseEntryPage(),
  ));
}
