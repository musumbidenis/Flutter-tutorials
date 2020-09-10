import 'package:madeniapp/Models/models.dart';
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
    join(dbPath, 'madeni7.db'),
    version: 1,
    onCreate: (Database database, int version) async {
      print("Creating tables");

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

Future<void> insertDebtor(Debtor debtor) async {
  final Database db = await database;

  // Insert the Debtor into the correct table
  await db.insert(
    'debtors',
    debtor.toMap(),
  );
}

Future<void> insertDebt(Debt debt) async {
  final Database db = await database;

  // Insert the Debtor into the correct table
  await db.insert(
    'debts',
    debt.toMap(),
  );
}

Future<void> insertPayment(Payment payment) async {
  final Database db = await database;

  // Insert the Payment into the correct table
  await db.insert(
    'payments',
    payment.toMap(),
  );
}

Future<List<Debtor>> getDebtors() async {
  final Database db = await database;

  // Query the table for all The Debtors.
  final List<Map<String, dynamic>> maps = await db.query('debtors');
  print(maps);
  // Convert the List<Map<String, dynamic> into a List<Debtor>.
  return List.generate(maps.length, (i) {
    return Debtor(
      name: maps[i]['name'],
      phone: maps[i]['phone'].toString(),
    );
  });
}

Future<List<Debt>> getDebts(String name) async {
  final Database db = await database;

  // Query the table for all The Debtors.
  final List<Map<String, dynamic>> maps =
      await db.rawQuery('SELECT * FROM debts WHERE name = ?', ['$name']);

  // Convert the List<Map<String, dynamic> into a List<Debt>.
  return List.generate(maps.length, (i) {
    var result = Debt(
        name: maps[i]['name'],
        debt: maps[i]['debt'],
        amount: maps[i]['amount'].toString(),
        timestamp: maps[i]['timestamp']);
    print(maps);
    return result;
  });
}

Future<List<Payment>> getPayments(String name) async {
  final Database db = await database;

  // Query the table for all The Payments.
  final List<Map<String, dynamic>> maps = await db.rawQuery(
      'SELECT name, total, paid FROM payments WHERE name = ?', ['$name']);

  // Convert the List<Map<String, dynamic> into a List<Debtor>.
  print(maps);
  return List.generate(maps.length, (i) {
    return Payment(
      name: maps[i]['name'],
      total: maps[i]['total'],
      paid: maps[i]['paid'],
    );
  });
}

getTotal() async {
  final Database db = await database;

  final List<Map<String, dynamic>> maps = await db
      .rawQuery('SELECT SUM(total) as total, SUM(paid) as paid FROM payments');
  print(maps);
  return maps.toList();
}

Future<void> updatePayment(String name) async {
  final db = await database;
  await db.rawUpdate(
      '''UPDATE payments SET total = (SELECT SUM(amount) as total FROM debts WHERE name = ?) WHERE name = ?''',
      ['$name', '$name']);
}

Future<void> reduceDebt(String name, String amount) async {
  final db = await database;
  await db.rawUpdate(
      'UPDATE payments SET paid = $amount + (SELECT paid FROM payments WHERE name = ?) WHERE name = ?',
      ['$name', '$name']);
}

Future<void> delete(String name) async {
  final db = await database;
  await db.rawDelete('DELETE FROM debtors WHERE name = ?', ['$name']);
  await db.rawDelete('DELETE FROM debts WHERE name = ?', ['$name']);
  await db.rawDelete('DELETE FROM payments WHERE name = ?', ['$name']);
}

// Future<List> debts() async {
//   final Database db = await database;
//   var result = await db.query('debts');
//   List debts = result.toList();
//   print(debts);
//   return debts;
// }

// getPayment() async {
//   final Database db = await database;
//   final List<Map<String, dynamic>> maps =
//       await db.rawQuery('SELECT * FROM payments');
//   print(maps);
//   return maps;
// }

// paid(String name, int total) async {
//   final Database db = await database;
//   final List<Map<String, dynamic>> maps = await db.rawQuery(
//       'SELECT SUM(amount) as total FROM debts WHERE name = ?', ['$name']);
//   return List.generate(maps.length, (index) {
//     total = maps[index]['total'];
//     print(total);
//     return total;
//   });
// }
