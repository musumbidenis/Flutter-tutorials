import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    print("database getter called");

    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'madeni.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print("Creating tables");

        await database.execute(
          "CREATE TABLE debtors(name TEXT PRIMARY KEY, phone INTEGER)",
        );
        await database.execute(
          "CREATE TABLE debts(debtId INTEGER PRIMARY KEY, name TEXT, debt TEXT, amount INTEGER, FOREIGN KEY(name) REFERENCES debtors(name))",
        );
      },
    );
  }
}
