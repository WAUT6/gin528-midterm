part of 'add_expense_bloc.dart';

sealed class AddExpenseEvent {}

final class AddExpenseEventAdd extends AddExpenseEvent {
  final Expense expense;

  AddExpenseEventAdd(this.expense);
}
