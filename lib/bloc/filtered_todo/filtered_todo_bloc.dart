import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../cubits/todo_filter/todo_filter_cubit.dart';
import '../../model/todo_model.dart';
import '../todo_filter/todo_filter_bloc.dart';
import '../todo_list/todo_list_bloc.dart';
import '../todo_serarch/todo_search_bloc.dart';

part 'filtered_todo_event.dart';
part 'filtered_todo_state.dart';

class FilteredTodoBloc extends Bloc<FilteredTodoEvent, FilteredTodoState> {
  final TodoSearchBloc todoSearchCubit;
  final TodoFilterBloc todoFilterCubit;
  final TodoListBloc todoListCubit;

  final List<Todo> intialTodos;

  late final StreamSubscription todoSearchCubitStreamSubscription;
  late final StreamSubscription todoFilterCubitStreamSubscription;
  late final StreamSubscription todoListCubitStreamSubscription;
  FilteredTodoBloc({
    required this.intialTodos,
    required this.todoSearchCubit,
    required this.todoFilterCubit,
    required this.todoListCubit,
  }) : super(FilteredTodoState(fillteredTodos: intialTodos)) {
    todoFilterCubitStreamSubscription =
        todoFilterCubit.stream.listen((TodoFilterState todoFilterState) {
      add(SetFillteredTodoEvent());
    });
    todoSearchCubitStreamSubscription =
        todoSearchCubit.stream.listen((TodoSearchState todoFilterState) {
      add(SetFillteredTodoEvent());
    });
    todoListCubitStreamSubscription =
        todoListCubit.stream.listen((TodoListState todoFilterState) {
      add(SetFillteredTodoEvent());
    });

    on<FilteredTodoEvent>((event, emit) {
      List<Todo> fillteredTodo = [];

      switch (todoFilterCubit.state.filter) {
        case Filter.active:
          fillteredTodo = todoListCubit.state.todos
              .where((Todo t) => !t.completed)
              .toList();
          break;
        case Filter.completed:
          fillteredTodo =
              todoListCubit.state.todos.where((Todo t) => t.completed).toList();
          break;
        case Filter.all:
        default:
          fillteredTodo = todoListCubit.state.todos;
          break;
      }
      print(todoSearchCubit.state.searchTerm);
      print(todoSearchCubit.state.searchTerm.isNotEmpty);

      if (todoSearchCubit.state.searchTerm.isNotEmpty) {
        fillteredTodo = todoListCubit.state.todos
            .where((Todo t) => t.desc
                .toLowerCase()
                .contains(todoSearchCubit.state.searchTerm.toLowerCase()))
            .toList();
      }

      emit(state.copyWith(fillteredTodos: fillteredTodo));
    });
  }
}
