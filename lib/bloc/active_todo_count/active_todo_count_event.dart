// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'active_todo_count_bloc.dart';

abstract class ActiveTodoCountEvent extends Equatable {
  const ActiveTodoCountEvent();

  @override
  List<Object> get props => [];
}

// class CalculateActiveTodoCountEvent extends ActiveTodoCountEvent {
//   final int activeTodocount;
//   const CalculateActiveTodoCountEvent({
//     required this.activeTodocount,
//   });

//   @override
//   String toString() =>
//       'CalculateActiveTodoCount(activeTodocount: $activeTodocount)';

//   @override
//   List<Object> get props => [activeTodocount];
// }

class CalculateActiveTodoCountEvent extends ActiveTodoCountEvent {}
