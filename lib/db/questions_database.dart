import 'package:first_app/models/User.dart';
import 'package:sqflite/sqflite.dart';

// Define the path to the database
String path = 'my_db.db';

class QuestionsDatabase {
  static final QuestionsDatabase instance = QuestionsDatabase._internal();

  factory QuestionsDatabase() {
    return instance;
  }

  QuestionsDatabase._internal();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDb('questionsDb');
    return _database;
  }

  Future<Database> _initDb(String filePath) async {
    final dbPath = await getDatabasesPath();
    print(dbPath);
    final path = dbPath + filePath;

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future _createDb(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final stringType = 'TEXT NOT NULL';

    db.execute('''
  CREATE TABLE $tableUsers (
  ${UserFields.id} $idType,
  ${UserFields.userName} $stringType,
  ${UserFields.createTime} $stringType
)
''');
  }

  Future<User> create(User user) async {
    final db = await instance.database;

    final id = await db.insert(tableUsers, user.toJson());

    return user.copy(
        id: id, userName: user.userName, createTime: user.createTime);
  }

  Future<User> get(int id) async {
    final db = await instance.database;

    final maps = await db.query(tableUsers,
        columns: UserFields.values,
        where: '${UserFields.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found!');
    }
  }

  Future<User> update(User user) async {
    final db = await instance.database;

    final id = await db.update(
      tableUsers,
      user.toJson(),
      where: '${UserFields.id} = ?',
      whereArgs: [user.id],
    );
  }

  Future<User> delete(User user) async {
    final db = await instance.database;

    final id = await db.delete(
      tableUsers,
      where: '${UserFields.id} = ?',
      whereArgs: [user.id],
    );

    return user.copy(
        id: id, userName: user.userName, createTime: user.createTime);
  }

  Future<User> createRaw(User user) async {
    final db = await instance.database;

    final json = user.toJson();

    final columns =
        '${UserFields.id}, ${UserFields.userName}, ${UserFields.createTime}';

    final values =
        '${json[UserFields.id]}, ${json[UserFields.userName]}, ${json[UserFields.createTime]}';

    final id = await db
        .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    return user.copy(
        id: id, userName: user.userName, createTime: user.createTime);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
