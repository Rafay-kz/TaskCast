import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_cast_app/core/theme/app_theme.dart';
import '../../../../common/widgets/custom_primary_button.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/todo.dart';
import '../bloc/todo_bloc.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(LoadTodos());
  }

  void _showAddTodoDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text(AppStrings.addTodo),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: AppStrings.todoTitle),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: AppStrings.todoDescription),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(AppStrings.cancel),
            ),
            CustomPrimaryButton(
              width: 100,
              onButtonPressed: () {
                final todo = Todo(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: titleController.text,
                  description: descController.text,
                  isCompleted: false,
                  createdAt: DateTime.now(),
                );
                context.read<TodoBloc>().add(AddTodo(todo: todo));
                Navigator.pop(context);
              },
              title: AppStrings.save,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.secondaryColor,
        shape: const CircleBorder(),
        onPressed: () => _showAddTodoDialog(context),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoLoaded) {
            if (state.todos.isEmpty) {
              return const Center(child: Text(AppStrings.noTodos));
            }
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return Dismissible(
                  key: ValueKey(todo.id),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) => context.read<TodoBloc>().add(DeleteTodo(id: todo.id)),
                  background: Container(
                    color: AppTheme.errorColor,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Card(
                    shadowColor: AppTheme.successColor,
                    elevation: 3,
                    margin: const EdgeInsets.all(5),
                    child: ListTile(
                      leading: Checkbox(
                        value: todo.isCompleted,
                        onChanged: (_) => context.read<TodoBloc>().add(ToggleTodo(id: todo.id)),
                      ),
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          decoration: todo.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      subtitle: Text(todo.description),
                    ),
                  ),
                );
              },
            );
          } else if (state is TodoError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text(AppStrings.loading));
        },
      ),
    );
  }
}
