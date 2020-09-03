import 'package:demo/Models/models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

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

Future<void> insertDebtor(Debtor debtor) async {
  final Database db = await database;

  // Insert the Debtor into the correct table
  await db.insert(
    'debtors',
    debtor.toMap(),
  );
}

Future<List<Debtor>> getDebtors() async {
  final Database db = await database;

  // Query the table for all The Debtors.
  final List<Map<String, dynamic>> maps = await db.query('debtors');

  // Convert the List<Map<String, dynamic> into a List<Debtor>.
  return List.generate(maps.length, (i) {
    return Debtor(
      name: maps[i]['name'],
      phone: maps[i]['phone'].toString(),
    );
  });
}

Future<List> debtors() async {
  final Database db = await database;
  var result = await db.query('debtors');
  List debtors = result.toList();
  print(debtors);
  return debtors;
}
