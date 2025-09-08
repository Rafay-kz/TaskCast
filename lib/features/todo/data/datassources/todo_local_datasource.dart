import 'package:hive/hive.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/todo_model.dart';

abstract class TodoLocalDataSource {
  Future<List<TodoModel>> getTodos();
  Future<void> addTodo(TodoModel todo);
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteTodo(String id);
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  @override
  Future<List<TodoModel>> getTodos() async {
    final box = await Hive.openBox<TodoModel>(AppConstants.todoBoxName);
    return box.values.toList();
  }

  @override
  Future<void> addTodo(TodoModel todo) async {
    final box = await Hive.openBox<TodoModel>(AppConstants.todoBoxName);
    await box.put(todo.id, todo);
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    final box = await Hive.openBox<TodoModel>(AppConstants.todoBoxName);
    await box.put(todo.id, todo);
  }

  @override
  Future<void> deleteTodo(String id) async {
    final box = await Hive.openBox<TodoModel>(AppConstants.todoBoxName);
    await box.delete(id);
  }
}