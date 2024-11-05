part of 'add_expense_bloc.dart';

sealed class AddExpenseState {}

final class AddExpenseStateNotAdded extends AddExpenseState {}

final class AddExpenseStateAdded extends AddExpenseState {
  final Expense expense;

  AddExpenseStateAdded(this.expense);
}
