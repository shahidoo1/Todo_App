import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/todo_modal.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'todo.db'),
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE todos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            createdAt TEXT
          )
          ''',
        );
      },
      version: 1,
    );
  }

  Future<int> addTodo(TodoModal todo) async {
    final db = await database;
    return await db.insert('todos', todo.toMap());
  }

  Future<List<TodoModal>> getTodos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('todos');
    return List.generate(maps.length, (i) {
      return TodoModal.fromMap(maps[i]);
    });
  }

  Future<int> deleteTodoById(int id) async {
    final db = await database;
    return await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
