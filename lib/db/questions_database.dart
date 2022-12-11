import 'package:first_app/models/User.dart';
import 'package:sqflite/sqflite.dart';

// Define the path to the database
String path = 'my_db.db';

class QuestionsDatabase {
  static final QuestionsDatabase instance = QuestionsDatabase._init();

  static Database _database;

  static QuestionsDatabase _init() {}

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDb('questionsDb');
    return _database;
  }

  Future<Database> _initDb(String filePath) async {
    final dbPath = await getDatabasesPath();
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
