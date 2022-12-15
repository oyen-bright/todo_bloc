part of 'todo_list_bloc.dart';

class TodoListState extends Equatable {
  final List<Todo> todos;

  const TodoListState(this.todos);

  TodoListState copyWith({
    List<Todo>? todos,
  }) {
    return TodoListState(
      todos ?? this.todos,
    );
  }

  factory TodoListState.initial() {
    return TodoListState([
      Todo(id: "1", desc: "Code"),
      Todo(desc: "An initial Toto"),
      Todo(desc: "Heading to the bank")
    ]);
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [todos];
}
