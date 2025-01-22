import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/todo_cubit.dart';
import 'package:flutter_application_1/database/db_helper.dart';
import 'package:flutter_application_1/pages/todo_homepage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  print(_dbHelper); // Check if _dbHelper is initialized properly

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) {
          print("Initializing TodoCubit");
          return TodoCubit(_dbHelper);
        }),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: TodoHomepage());
  }
}
