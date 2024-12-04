import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/expense.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key, required this.onCreated});

  final Function(Expense) onCreated;

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  Category? selectedCategory;
  DateTime? selectedDate;

  @override
  void dispose() {
    _titleController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void onCancel() {
    Navigator.pop(context);
  }

  void onAdd() {
    if (_titleController.text.isEmpty ||
        _valueController.text.isEmpty ||
        selectedCategory == null ||
        selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Missing Information"),
          content: const Text("Please fill all fields"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop(); // Close the dialog
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    final title = _titleController.text;
    final amount = double.tryParse(_valueController.text) ?? 0.0;

    final expense = Expense(
      title: title,
      amount: amount,
      date: selectedDate!,
      category: selectedCategory!,
    );

    widget.onCreated(expense);

    Navigator.pop(context);
  }

  Future<void> _pickDate() async {
    final currentDate = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(currentDate.year - 5),
      lastDate: DateTime(currentDate.year + 5),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          const SizedBox(height: 20),
          // Row 1: Amount and Date Picker
          Row(
            children: [
              // Amount Field
              Expanded(
                flex: 1,
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  controller: _valueController,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    prefix: Text('\$'),
                  ),
                ),
              ),
              const SizedBox(width: 50),
              // Date Picker
              Expanded(
                flex: 1,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  onPressed: _pickDate,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text first
                      Text(
                        selectedDate == null
                            ? 'No date selected'
                            : '${selectedDate!.toLocal()}'.split(' ')[0],
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 5), // Add space between text and icon
                      // Icon after text
                      const Icon(
                        Icons.date_range,
                        size: 20,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Row 2: Dropdown, Cancel, and Save Buttons
          Row(
            children: [
              // Dropdown
              Expanded(
                flex: 1,
                child: DropdownButtonFormField<Category>(
                  value: selectedCategory,
                  hint: const Text('Select Category'),
                  items: Category.values.map((category) {
                    return DropdownMenuItem<Category>(
                      value: category,
                      child: Row(
                        children: [
                          Icon(category.icon, size: 20),
                          const SizedBox(width: 10),
                          Text(category.name),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (Category? value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                ),
              ),
              const SizedBox(width: 100),
              // Cancel Button
              ElevatedButton(
                onPressed: onCancel,
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 10),
              // Save Button
              ElevatedButton(
                onPressed: onAdd,
                child: const Text('Save Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
