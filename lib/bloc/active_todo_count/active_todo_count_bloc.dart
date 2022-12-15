import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_cubit/bloc/todo_list/todo_list_bloc.dart';

import '../../cubits/active_todo_count/active_todo_count_cubit.dart';
import '../../model/todo_model.dart';

part 'active_todo_count_event.dart';
part 'active_todo_count_state.dart';

class ActiveTodoCountBloc
    extends Bloc<ActiveTodoCountEvent, ActiveTodoCountState> {
  TodoListBloc todoListCubit;

  final int initialActiveTodoCount;

  late final StreamSubscription todoListBlocStreamSubscrption;
  ActiveTodoCountBloc({
    required this.initialActiveTodoCount,
    required this.todoListCubit,
  }) : super(ActiveTodoCountState(activeTodoCount: initialActiveTodoCount)) {
    int? count;
    todoListBlocStreamSubscrption =
        todoListCubit.stream.listen((TodoListState todoListState) {
      count =
          todoListState.todos.where((Todo t) => !t.completed).toList().length;
      add(CalculateActiveTodoCountEvent());
    });
    on<CalculateActiveTodoCountEvent>((CalculateActiveTodoCountEvent event,
        Emitter<ActiveTodoCountState> emit) {
      emit(state.copyWith(activeTodoCount: count!));
    });
  }
  @override
  Future<void> close() {
    // TODO: implement close
    todoListBlocStreamSubscrption.cancel();
    return super.close();
  }
}
