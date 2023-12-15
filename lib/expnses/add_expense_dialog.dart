import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'category_icons.dart';

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
  TextEditingController noteController = TextEditingController();
  TextEditingController tagController = TextEditingController();

  String? categoryName;
  IconData? categoryIcon;
  Color? categoryColor;

  DateTime selectedDate = DateTime.now();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
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
    noteController.dispose();
    tagController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    PermissionStatus status = await Permission.camera.request();

    if (status.isGranted) {
      final pickedFile =
          await ImagePicker().getImage(source: ImageSource.camera);

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } else {
      print('Camera permission denied');
    }
  }

  late List<CategoryIcon> categories = [
    const CategoryIcon(
      icon: Icons.signal_cellular_alt,
      label: 'EMI',
    ),
    const CategoryIcon(
      icon: Icons.star,
      label: 'Entertainment',
      color: Colors.blue,
    ),
    const CategoryIcon(
      icon: Icons.restaurant,
      label: 'Food & Drinks',
      color: Colors.pink,
    ),
    const CategoryIcon(
      icon: Icons.local_gas_station,
      label: 'Fuel',
      color: Colors.orange,
    ),
    CategoryIcon(
      icon: Icons.medical_services,
      label: 'Health',
      color: Colors.yellow.shade600,
    ),
    const CategoryIcon(
      icon: Icons.more_horiz,
      label: 'Others',
    ),
    const CategoryIcon(
      icon: Icons.shopping_cart,
      label: 'Shopping',
      color: Colors.cyan,
    ),
    const CategoryIcon(
      icon: Icons.work,
      label: 'Travel',
      color: Colors.purple,
    ),
    const CategoryIcon(
      icon: Icons.add,
      label: 'Add category',
      color: Colors.red,
    ),
  ];

  bool isCountedInTotalSpends = true;

  String dateAsString(DateTime date) {
    final dateTimeFormatter = DateFormat("dd MMM");
    return dateTimeFormatter.format(date);
  }

  int selectedCategoryIndex = -1;

  void floatingAction() {
    double amount = double.tryParse(amountController.text) ?? 0.0;
    String description = descriptionController.text;
    String notes = noteController.text;
    String tags = tagController.text;

    if (description.isNotEmpty && amount > 0.0 && selectedCategoryIndex >= 0) {
      Navigator.of(context).pop({
        'amount': amount,
        'description': description,
        'selectedDate': selectedDate,
        'notes': notes,
        'tags': tags,
        'image': _selectedImage,
        'category': categories[selectedCategoryIndex],
        // 'categoryLabel': categoryLabel,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: SimpleDialog(
            title: const Text('Add Expense'),
            titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
            children: [
              ListTile(
                leading: const SizedBox(
                  child: Icon(Icons.currency_rupee_outlined),
                ),
                title: TextField(
                  controller: amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    hintText: 'Enter Amount',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const Divider(),
              // TextField(
              //   controller: titleController,
              //   decoration: InputDecoration(hintText: 'Title'),
              // ),
              ListTile(
                leading: const SizedBox(
                  child: Icon(Icons.notes),
                ),
                title: TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'What was this spend for?',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const SizedBox(
                  child: Icon(Icons.notes),
                ),
                title: TextField(
                  controller: noteController,
                  decoration: const InputDecoration(
                    hintText: 'Notes',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: GestureDetector(
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );

                    if (pickedDate == null) {
                      return;
                    }

                    if (mounted) {
                      final TimeOfDay? pickedTime = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());

                      if (pickedTime == null) {
                        return;
                      }

                      setState(() {
                        selectedDate = pickedDate.copyWith(
                            hour: pickedTime.hour, minute: pickedTime.minute);
                      });
                    }
                  },
                  child: DefaultTextStyle(
                    style: const TextStyle(color: Colors.black),
                    child: Text(
                        '${dateAsString(selectedDate)}, ${selectedDate.hour}:${selectedDate.minute}'),
                  ),
                ),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.category),
                title: Text('Category'),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 9 / 10,
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  children: List.generate(
                    categories.length,
                    (index) => CategoryIcon(
                      icon: categories[index].icon,
                      label: categories[index].label,
                      color: categories[index].color,
                      backgroundColor: selectedCategoryIndex == index
                          ? Colors.grey.shade300
                          : null,
                      onTap: () {
                        setState(() {
                          selectedCategoryIndex = index;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Add Image'),
                onTap: () async => await _pickImage(),
              ),

              _selectedImage != null
                  ? Image.file(_selectedImage!, height: 100, width: 100)
                  : Container(),
              const Divider(),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 64.0),
                child: ElevatedButton(
                  onPressed: () => floatingAction(),
                  child: const Text('Save'),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
