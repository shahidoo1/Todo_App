import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/db_helper.dart';
import 'package:flutter_application_1/models/todo_modal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoCubit extends Cubit<List<TodoModal>> {
  final DatabaseHelper _dbHelper;

  TodoCubit(this._dbHelper) : super([]) {
    fetchTodos();
  }

  // Fetch todos from the database
  Future<void> fetchTodos() async {
    emit([]); // Show loading by emitting an empty list initially
    final todos = await _dbHelper.getTodos(); // Fetch data
    emit(todos); // Emit the fetched todos
  }

  // Add a todo
  Future<void> addTodo(String title, String description) async {
    final todo = TodoModal(
      id: UniqueKey().hashCode,
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );
    await _dbHelper.addTodo(todo);
    fetchTodos();
  }

  // Delete a todo
  Future<void> deleteTodoAt(int index) async {
    final todo = state[index];
    await _dbHelper.deleteTodoById(todo.id);
    fetchTodos();
  }
}
