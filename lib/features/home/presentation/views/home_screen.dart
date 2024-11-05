import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gin528_midterm/core/enums/category.dart';
import 'package:gin528_midterm/features/home/domain/entities/expense.dart';
import 'package:gin528_midterm/features/home/presentation/bloc/add_expense_bloc/add_expense_bloc.dart';
import 'package:gin528_midterm/features/home/presentation/views/add_expense_screen.dart';
import 'package:gin528_midterm/features/home/presentation/widgets/category_widget.dart';
import 'package:gin528_midterm/features/home/presentation/widgets/expense_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? _selectedIndex;

  List<Expense> _expensesFiltered() {
    if (_selectedIndex == null) {
      return _expenses;
    }
    if (_selectedIndex == 0) {
      return _expenses
          .where((element) => element.category == Category.travel)
          .toList();
    } else if (_selectedIndex == 1) {
      return _expenses
          .where((element) => element.category == Category.food)
          .toList();
    } else {
      return _expenses
          .where((element) => element.category == Category.entertainment)
          .toList();
    }
  }

  final List<Expense> _expenses = [
    Expense(
      name: 'Groceries',
      category: Category.food,
      amount: 200,
      date: DateTime.now(),
    ),
    Expense(
      name: 'Fuel',
      category: Category.food,
      amount: 100,
      date: DateTime.now(),
    ),
    Expense(
      name: 'Rent',
      category: Category.travel,
      amount: 2000,
      date: DateTime.now(),
    ),
    Expense(
      name: 'Movie',
      category: Category.entertainment,
      amount: 50,
      date: DateTime.now(),
    ),
  ];

  double get _totalExpenses => _expenses.fold(
      0, (previousValue, element) => previousValue + element.amount);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddExpenseBloc, AddExpenseState>(
      listener: (context, state) {
        if (state is AddExpenseStateAdded) {
          setState(() {
            _expenses.add(state.expense);
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Your Expenses',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddExpenseScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add, size: 32, color: Colors.white),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 100,
              color: Colors.blue.withOpacity(0.8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Expenses',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '\$$_totalExpenses',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (_selectedIndex == 0) {
                          setState(() {
                            _selectedIndex = null;
                          });
                          return;
                        }
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
                        if (_selectedIndex == 1) {
                          setState(() {
                            _selectedIndex = null;
                          });
                          return;
                        }
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
                        if (_selectedIndex == 2) {
                          setState(() {
                            _selectedIndex = null;
                          });
                          return;
                        }
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
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: _expensesFiltered().length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final expenses = _expensesFiltered();
                    return ExpenseWidget(expense: expenses[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
