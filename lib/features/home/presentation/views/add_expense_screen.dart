import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gin528_midterm/core/enums/category.dart';
import 'package:gin528_midterm/features/home/domain/entities/expense.dart';
import 'package:gin528_midterm/features/home/presentation/bloc/add_expense_bloc/add_expense_bloc.dart';
import 'package:gin528_midterm/features/home/presentation/widgets/category_widget.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  int _selectedIndex = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _amountController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _amountController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Add Expense', style: TextStyle(color: Colors.white)),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 16,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                    child: CategoryWidget(
                      isSelected: _selectedIndex == 0,
                      title: "Travel",
                      icon: Image.asset(
                        "assets/images/travel.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                    child: CategoryWidget(
                      isSelected: _selectedIndex == 1,
                      title: "Food",
                      icon: Image.asset(
                        "assets/images/food.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 2;
                      });
                    },
                    child: CategoryWidget(
                      isSelected: _selectedIndex == 2,
                      title: "Entertainment",
                      icon: Image.asset(
                        "assets/images/popcorn.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                style: const TextStyle(
                  color: Colors.black,
                ),
                controller: _nameController,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                controller: _amountController,
                cursorColor: Colors.black,
                style: const TextStyle(
                  color: Colors.black,
                ),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount';
                  }
                  return null;
                },
              ),
            ),
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<AddExpenseBloc, AddExpenseState>(
                bloc: context.read<AddExpenseBloc>(),
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final name = _nameController.text;
                        final amount = double.parse(_amountController.text);
                        final date = DateTime.now();
                        Category category = Category.travel;
                        if (_selectedIndex == 1) {
                          category = Category.food;
                        } else if (_selectedIndex == 2) {
                          category = Category.entertainment;
                        }
                        context.read<AddExpenseBloc>().add(
                              AddExpenseEventAdd(
                                Expense(
                                  name: name,
                                  category: category,
                                  amount: amount,
                                  date: date,
                                ),
                              ),
                            );
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Add Expense',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
