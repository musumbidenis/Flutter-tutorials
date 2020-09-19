import 'package:demo/Models/models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

Database _database;

/*Initialize database != null */
Future<Database> get database async {
  if (_database != null) {
    return _database;
  }

  _database = await createDatabase();

  return _database;
}

/*Creates database && tables */
Future<Database> createDatabase() async {
  String dbPath = await getDatabasesPath();

  return await openDatabase(
    join(dbPath, 'madeni7.db'),
    version: 1,
    onCreate: (Database database, int version) async {
      await database.execute(
        "CREATE TABLE debtors(name TEXT PRIMARY KEY, phone INTEGER)",
      );
      await database.execute(
        "CREATE TABLE debts(debtId INTEGER PRIMARY KEY, name TEXT, debt TEXT, amount INTEGER, timestamp VARCHAR, FOREIGN KEY(name) REFERENCES debtors(name))",
      );
      await database.execute(
        "CREATE TABLE payments(name TEXT PRIMARY KEY, total INTEGER, paid INTEGER, FOREIGN KEY(name) REFERENCES debtors(name))",
      );
    },
  );
}

/*Inserts a new debtor to db */
Future<void> insertDebtor(Debtor debtor) async {
  final Database db = await database;
  await db.insert(
    'debtors',
    debtor.toMap(),
  );
}

/*Inserts a new debt to db */
Future<void> insertDebt(Debt debt) async {
  final Database db = await database;
  await db.insert(
    'debts',
    debt.toMap(),
  );
}

/*Inserts a new payment record to db */
Future<void> insertPayment(Payment payment) async {
  final Database db = await database;
  await db.insert(
    'payments',
    payment.toMap(),
  );
}

/*Gets the list of debtors */
Future<List<Debtor>> getDebtors() async {
  final Database db = await database;
  final List<Map<String, dynamic>> maps = await db.query('debtors');

  return List.generate(maps.length, (i) {
    return Debtor(
      name: maps[i]['name'],
      phone: maps[i]['phone'].toString(),
    );
  });
}

/*Gets the list of debts owed by a debtor */
Future<List<Debt>> getDebts(String name) async {
  final Database db = await database;
  final List<Map<String, dynamic>> maps =
      await db.rawQuery('SELECT * FROM debts WHERE name = ?', ['$name']);

  return List.generate(maps.length, (i) {
    var result = Debt(
        name: maps[i]['name'],
        debt: maps[i]['debt'],
        amount: maps[i]['amount'].toString(),
        timestamp: maps[i]['timestamp']);
    return result;
  });
}

/*Gets the payment records for a debtor */
Future<List<Payment>> getPayments(String name) async {
  final Database db = await database;
  final List<Map<String, dynamic>> maps = await db.rawQuery(
      'SELECT name, total, paid FROM payments WHERE name = ?', ['$name']);

  return List.generate(maps.length, (i) {
    return Payment(
      name: maps[i]['name'],
      total: maps[i]['total'],
      paid: maps[i]['paid'],
    );
  });
}

/*Deletes all records of a debtor from db */
Future<void> delete(String name) async {
  final db = await database;

  await db.rawDelete('DELETE FROM debtors WHERE name = ?', ['$name']);
  await db.rawDelete('DELETE FROM debts WHERE name = ?', ['$name']);
  await db.rawDelete('DELETE FROM payments WHERE name = ?', ['$name']);
}

/*Gets the total of all payment records in db */
getTotal() async {
  final Database db = await database;
  final List<Map<String, dynamic>> maps = await db
      .rawQuery('SELECT SUM(total) as total, SUM(paid) as paid FROM payments');

  return maps.toList();
}

/*Updates payment records on adding a new debt to db */
Future<void> updatePayment(String name) async {
  final db = await database;

  await db.rawUpdate(
      '''UPDATE payments SET total = (SELECT SUM(amount) as total FROM debts WHERE name = ?) WHERE name = ?''',
      ['$name', '$name']);
}

/*Updates payment record of debtor on reducing their total debt */
Future<void> reduceDebt(String name, String amount) async {
  final db = await database;

  await db.rawUpdate(
      'UPDATE payments SET paid = $amount + (SELECT paid FROM payments WHERE name = ?) WHERE name = ?',
      ['$name', '$name']);
}

/*Gets the time of day */
greeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good Morning';
  }
  if (hour < 17) {
    return 'Good Afternoon';
  }
  return 'Good Evening';
}
