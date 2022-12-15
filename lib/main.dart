import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/bloc/active_todo_count/active_todo_count_bloc.dart';
import 'bloc/bloc.dart';
import 'package:todo_cubit/pages/todopage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoFilterBloc>(
          create: (BuildContext context) => TodoFilterBloc(),
        ),
        BlocProvider<TodoSearchBloc>(
          create: (BuildContext context) => TodoSearchBloc(),
        ),
        BlocProvider<TodoListBloc>(
          lazy: false,
          create: (BuildContext context) => TodoListBloc(),
        ),
        BlocProvider<ActiveTodoCountBloc>(
          create: (BuildContext context) => ActiveTodoCountBloc(
              initialActiveTodoCount:
                  context.read<TodoListBloc>().state.todos.length,
              todoListCubit: context.read<TodoListBloc>()),
        ),
        BlocProvider<FilteredTodoBloc>(
          create: (BuildContext context) => FilteredTodoBloc(
              intialTodos: context.read<TodoListBloc>().state.todos,
              todoFilterCubit: context.read<TodoFilterBloc>(),
              todoListCubit: context.read<TodoListBloc>(),
              todoSearchCubit: context.read<TodoSearchBloc>()),
        ),
      ],
      child: MaterialApp(
        title: 'Todo',
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        home: const TodoPage(),
      ),
    );
  }
}
