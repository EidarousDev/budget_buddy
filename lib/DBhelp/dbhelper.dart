import 'dart:async';

import '../models/settings_model.dart';
import '../models/transaction.dart';

import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  // function to create the database
  static Future<sql.Database> getDatabase() async {
    final dbpath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbpath, 'spendings.db'),
        onCreate: (db, version) {
      sql.Batch batch = db.batch();
      batch.execute(
          'CREATE TABLE settings(id INTEGER PRIMARY KEY,salary_amount INTEGER,savings_goal_amount INTEGER,date TEXT)');
      batch.execute(
          'CREATE TABLE transactions(id TEXT PRIMARY KEY,title TEXT,amount INTEGER,date TEXT,category TEXT)');
      return batch.commit();
    }, version: 1);
  }

  //Inserting the transaction data
  static Future<void> insert(Transaction transaction) async {
    final db = await DBHelper.getDatabase();
    await db.insert('transactions', transaction.toMap(transaction),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  //Retereving the transaction data
  static Future<List<Map<String, dynamic>>> fetch() async {
    final sqlDb = await DBHelper.getDatabase();
    return sqlDb.query('transactions');
  }

  //deleting the transactions
  static Future<void> delete(String id) async {
    final sqlDb = await DBHelper.getDatabase();
    await sqlDb.delete('transactions', where: "id=?", whereArgs: [id]);
  }

  /// ====== Mahmoud Eidarous ====== ///
  /// Settings Table
  //Inserting the settings data
  static Future<void> updateSettings(Settings settings) async {
    final db = await DBHelper.getDatabase();
    await db.insert('settings', settings.toMap(settings),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  //Retrieving the transaction data
  static Future<List<Settings>> fetchSettings() async {
    final sqlDb = await DBHelper.getDatabase();
    List<Map<String, dynamic>> query = await sqlDb.query('settings');
    return query
        .map((e) => Settings(
            salaryAmount: e['salary_amount'],
            savingAmount: e['savings_goal_amount']))
        .toList();
  }
}
