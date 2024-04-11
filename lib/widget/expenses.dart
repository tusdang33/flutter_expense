import 'package:flutter/material.dart';
import 'package:flutter_expense/models/expenses_model.dart';

class Expenses extends StatelessWidget {
  const Expenses({super.key, required this.expense});
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(expense.title),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(expense.formatedPrice()),
                const Expanded(child: Spacer()),
                Icon(expense.getCategoryIcon(expense.category)),
                Text(expense.date.toString()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
