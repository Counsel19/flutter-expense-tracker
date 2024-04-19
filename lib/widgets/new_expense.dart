import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({
    super.key,
    required this.onAddExpense,
  });

  final void Function(Expense) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.work;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    var pickedDate = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid input"),
          content: const Text("Please make sure you enter a valid inputs "),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx), child: const Text("Ok"))
          ],
        ),
      );
      return;
    }

    final newExpense = Expense(
        amount: enteredAmount,
        category: _selectedCategory,
        date: _selectedDate!,
        title: _titleController.text);
    widget.onAddExpense(newExpense);

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (ctx, contraints) {
        final width = contraints.maxWidth;
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            maxLength: 50,
                            decoration: const InputDecoration(
                              label: Text("Title"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixText: "\$ ",
                              label: Text("Amount"),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: _titleController,
                      maxLength: 50,
                      decoration: const InputDecoration(
                        label: Text("Title"),
                      ),
                    ),
                  if (width >= 600)
                    Row(
                      children: [
                        DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category.name.toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? "Selected Date"
                                    : formatter.format(_selectedDate!),
                              ),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixText: "\$ ",
                              label: Text("Amount"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? "Selected Date"
                                    : formatter.format(_selectedDate!),
                              ),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  const SizedBox(
                    height: 16,
                  ),
                  if (width >= 60)
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text("Save Expense"),
                        )
                      ],
                    )
                  else
                    Row(
                      children: [
                        DropdownButton(
                            value: _selectedCategory,
                            items: Category.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(
                                      category.name.toUpperCase(),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              setState(() {
                                _selectedCategory = value;
                              });
                            }),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text("Save Expense"),
                        )
                      ],
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
