import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/todo_model.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(TodoListState.initial()) {
    on<AddTaskEvent>((event, emit) {
      final newTodo = [...state.todos, Todo(desc: event.desc)];
      emit(state.copyWith(todos: newTodo));
    });
    on<EditTodoEvent>(_editTodoEvent);
    on<ToggleEvent>(_toggleEvent);
    on<RemoveTodoEvent>(_removeTodoEvent);
  }

  void _editTodoEvent(EditTodoEvent event, Emitter<TodoListState> emit) {
    final todos = state.todos.map((Todo todo) {
      if (todo.id == event.id) {
        return Todo(id: event.id, desc: event.desc, completed: todo.completed);
      }
      return todo;
    }).toList();

    emit(state.copyWith(todos: todos));
  }

  void _toggleEvent(ToggleEvent event, Emitter<TodoListState> emit) {
    final todos = state.todos.map((Todo todo) {
      if (todo.id == event.id) {
        return Todo(id: event.id, desc: todo.desc, completed: !todo.completed);
      }
      return todo;
    }).toList();

    emit(state.copyWith(todos: todos));
  }

  void _removeTodoEvent(RemoveTodoEvent event, Emitter<TodoListState> emit) {
    final todos = state.todos.where((Todo t) => t.id != event.todo.id).toList();
    emit(state.copyWith(todos: todos));
  }
}
