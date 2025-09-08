import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/todo.dart';
import '../../domain/usecases/todo_usecase.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodosUseCase getTodosUseCase;
  final AddTodoUseCase addTodoUseCase;
  final ToggleTodoUseCase toggleTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;

  TodoBloc({
    required this.getTodosUseCase,
    required this.addTodoUseCase,
    required this.toggleTodoUseCase,
    required this.deleteTodoUseCase,
  }) : super(TodoInitial()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<ToggleTodo>(_onToggleTodo);
    on<DeleteTodo>(_onDeleteTodo);
  }

  Future<void> _onLoadTodos(
      LoadTodos event,
      Emitter<TodoState> emit,
      ) async {
    emit(TodoLoading());

    try {
      final todos = await getTodosUseCase();
      emit(TodoLoaded(todos: todos));
    } catch (e) {
      emit(TodoError(message: e.toString()));
    }
  }

  Future<void> _onAddTodo(
      AddTodo event,
      Emitter<TodoState> emit,
      ) async {
    try {
      await addTodoUseCase(event.todo);
      final todos = await getTodosUseCase();
      emit(TodoLoaded(todos: todos));
    } catch (e) {
      emit(TodoError(message: e.toString()));
    }
  }

  Future<void> _onToggleTodo(
      ToggleTodo event,
      Emitter<TodoState> emit,
      ) async {
    try {
      await toggleTodoUseCase(event.id);
      final todos = await getTodosUseCase();
      emit(TodoLoaded(todos: todos));
    } catch (e) {
      emit(TodoError(message: e.toString()));
    }
  }

  Future<void> _onDeleteTodo(
      DeleteTodo event,
      Emitter<TodoState> emit,
      ) async {
    try {
      await deleteTodoUseCase(event.id);
      final todos = await getTodosUseCase();
      emit(TodoLoaded(todos: todos));
    } catch (e) {
      emit(TodoError(message: e.toString()));
    }
  }
}