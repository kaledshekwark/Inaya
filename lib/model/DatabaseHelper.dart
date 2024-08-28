import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:babycare2/model/BreastfeedingSessi4.dart';


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'babycare.db');
    return await openDatabase(
      path,
      version: 4, // تحديث النسخة لإضافة جدول جديد
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE breastfeeding_sessions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      startTime TEXT,
      duration INTEGER,
      isLeftBreast INTEGER,
      date TEXT   
    )
  ''');

      await db.execute('''
    CREATE TABLE artificial_breastfeeding_sessions (
      id INTEGER PRIMARY KEY,
      milkAmount REAL,
      date TEXT,   
      time TEXT  
    )
  ''');

    await db.execute('''
      CREATE TABLE pumped_breastfeeding_sessions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        milkAmount REAL,
        time TEXT,
         date TEXT,
        breastSide TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE feeding_sessions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        foodAmount  REAL,
        time TEXT,
        foodName TEXT,        
        comments TEXT         
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE artificial_breastfeeding_sessions (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          milkAmount REAL,
          time TEXT
        )
      ''');
    }
    if (oldVersion < 3) {
      await db.execute('''
        CREATE TABLE pumped_breastfeeding_sessions (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          milkAmount REAL,
          time TEXT,
          breastSide TEXT
        )
      ''');
    }
    if (oldVersion < 4) {
      await db.execute('''
        CREATE TABLE  feeding_sessions (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          foodAmount REAL,
          time TEXT,
          foodName TEXT,
          comments TEXT
        )
      ''');
    }
  }

  Future<int> insertSession(BreastfeedingSession session) async {
    final db = await database;
    return await db.insert('breastfeeding_sessions', session.toMap());
  }

  Future<int> insertArtificialSession(double milkAmount, String time, String date) async {
    final db = await database;
    return await db.insert('artificial_breastfeeding_sessions', {
      'milkAmount': milkAmount,
      'time': time,
      'date': date,
    });
  }

  Future<int> insertPumpedSession(double milkAmount, String time, String date, String breastSide) async {
    final db = await database;
    return await db.insert('pumped_breastfeeding_sessions', {
      'milkAmount': milkAmount,
      'time': time,
      'breastSide': breastSide,
      'date': date,
    });
  }

  Future<List<Map<String, dynamic>>> getArtificialSessions() async {
    final db = await database;
    return await db.query('artificial_breastfeeding_sessions');
  }

  Future<List<Map<String, dynamic>>> getPumpedSessions() async {
    final db = await database;
    return await db.query('pumped_breastfeeding_sessions');
  }

  Future<List<BreastfeedingSession>> getSessions({required bool isLeftBreast}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'breastfeeding_sessions',
      where: 'isLeftBreast = ?',
      whereArgs: [isLeftBreast ? 1 : 0],
    );

    return List.generate(maps.length, (i) {
      return BreastfeedingSession.fromMap(maps[i]);
    });
  }
  Future<int> insertFeedingSession(double foodAmount, String time,   String foodName, String comments) async {
    final db = await database;
    return await db.insert('feeding_sessions', {
      'foodAmount': foodAmount,
      'time': time,
       'foodName': foodName,
      'comments': comments,
    });
  }
  Future<List<Map<String, dynamic>>> getFeedingSessions() async {
    final db = await database;
    return await db.query('feeding_sessions');
  }
}
