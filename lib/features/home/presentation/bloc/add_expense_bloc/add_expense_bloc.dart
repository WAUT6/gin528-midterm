import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gin528_midterm/features/home/domain/entities/expense.dart';

part 'add_expense_event.dart';
part 'add_expense_state.dart';

class AddExpenseBloc extends Bloc<AddExpenseEvent, AddExpenseState> {
  AddExpenseBloc() : super(AddExpenseStateNotAdded()) {
    on<AddExpenseEventAdd>((event, emit) {
      emit(AddExpenseStateAdded(event.expense));
    });
  }
}
