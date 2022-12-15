// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_list_bloc.dart';

abstract class TodoListEvent extends Equatable {
  const TodoListEvent();

  @override
  List<Object> get props => [];
}

class AddTaskEvent extends TodoListEvent {
  final String desc;
  const AddTaskEvent({
    required this.desc,
  });

  @override
  String toString() => 'AddTask(desc: $desc)';

  @override
  List<Object> get props => [desc];
}

class EditTodoEvent extends TodoListEvent {
  final String id;
  final String desc;
  const EditTodoEvent({
    required this.id,
    required this.desc,
  });

  @override
  String toString() => 'EditTodo(id: $id, desc: $desc)';

  @override
  List<Object> get props => [desc, id];
}

class ToggleEvent extends TodoListEvent {
  final String id;
  const ToggleEvent({
    required this.id,
  });

  @override
  String toString() => 'toggleEvent(id: $id)';

  @override
  List<Object> get props => [id];
}

class RemoveTodoEvent extends TodoListEvent {
  final Todo todo;
  const RemoveTodoEvent({
    required this.todo,
  });

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'RemoveTodoEvent(todo: $todo)';
}
