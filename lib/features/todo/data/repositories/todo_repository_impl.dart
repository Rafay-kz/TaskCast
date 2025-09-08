import '../models/todo_model.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datassources/todo_local_datasource.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;

  TodoRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Todo>> getTodos() async {
    final todoModels = await localDataSource.getTodos();
    return todoModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> addTodo(Todo todo) async {
    final todoModel = TodoModel.fromEntity(todo);
    await localDataSource.addTodo(todoModel);
  }

  @override
  Future<void> toggleTodo(String id) async {
    final todos = await localDataSource.getTodos();
    final todo = todos.firstWhere((t) => t.id == id);
    final updatedTodo = todo.copyWith(isCompleted: !todo.isCompleted);
    await localDataSource.updateTodo(updatedTodo);
  }

  @override
  Future<void> deleteTodo(String id) async {
    await localDataSource.deleteTodo(id);
  }
}