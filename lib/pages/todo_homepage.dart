import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/todo_cubit.dart';
import 'package:flutter_application_1/models/todo_modal.dart';
import 'package:flutter_application_1/pages/add_todo_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TodoHomepage extends StatefulWidget {
  const TodoHomepage({super.key});

  @override
  State<TodoHomepage> createState() => _TodoHomepageState();
}

class _TodoHomepageState extends State<TodoHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Todo List"),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<TodoCubit, List<TodoModal>>(
              builder: (context, todos) {
                return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return Dismissible(
                      key: ValueKey(index), // Use a unique key for each item
                      direction: DismissDirection
                          .endToStart, // Swipe from right to left
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (direction) {
                        // Handle the delete action
                        context.read<TodoCubit>().deleteTodoAt(
                            index); // Call your delete method in TodoCubit
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${todo.title} deleted."),
                          ),
                        );
                      },

                      child: ListTile(
                        title: Text(todo.title),
                        subtitle: Text(todo.description),
                        trailing: Text(
                          DateFormat.yMMMd().format(todo.createdAt),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddTodoPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
