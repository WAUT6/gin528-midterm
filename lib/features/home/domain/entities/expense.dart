import '../../../../core/enums/category.dart';

class Expense {
  final String name;
  final Category category;
  final double amount;
  final DateTime date;

  Expense({
    required this.name,
    required this.category,
    required this.amount,
    required this.date,
  });
}
