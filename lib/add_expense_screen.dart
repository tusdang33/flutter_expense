import 'package:flutter/material.dart';
import 'package:flutter_expense/models/expenses_model.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<AddExpenseScreen> createState() => _AddExpense();
}

class _AddExpense extends State<AddExpenseScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presendDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        firstDate: firstDate,
        lastDate: now,
        initialDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpense() {
    final enterdAmount = double.tryParse(_amountController.text);
    final amountIsValid = enterdAmount != null && enterdAmount >= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsValid ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                  title: const Text("Error"),
                  content: const Text("Input not valid"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Close"))
                  ]));
      return;
    }
    widget.onAddExpense(Expense(
        title: _titleController.text,
        price: enterdAmount,
        category: _selectedCategory,
        date: _selectedDate));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: const InputDecoration(label: Text("title")),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      label: Text("Amount"), prefixText: "\$"),
                ),
                Text(
                  _selectedDate == null
                      ? "No date selected"
                      : _selectedDate.toString(),
                ),
                IconButton(
                    onPressed: _presendDatePicker,
                    icon: const Icon(Icons.calendar_month))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map((category) => DropdownMenuItem(
                            value: category, child: Text(category.name)))
                        .toList(),
                    onChanged: (category) {
                      if (category == null) {
                        return;
                      }
                      setState(() {
                        _selectedCategory = category;
                      });
                    }),
                const Spacer(),
                TextButton(
                    child: const Text("Cancel"),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                TextButton(
                    onPressed: _submitExpense,
                    child: const Text("Save Expense")),
              ],
            )
          ],
        ));
  }
}
