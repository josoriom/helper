import 'dart:io';

import 'package:helper/models/errand_model.dart';
import 'package:helper/models/models.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static dynamic _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'HelperDB.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE Agenda(
          id INTEGER PRIMARY KEY,
          label TEXT,
          status INTEGER,
          date TEXT,
          priority TEXT,
          notification TEXT,
          observation TEXT
        )
      ''');

      await db.execute('''
        CREATE TABLE Contacts(
          id INTEGER PRIMARY KEY,
          contact TEXT,
          phone INTEGER,
          mobil INTEGER,
          addres TEXT,
          nicks TEXT
        )
      ''');
    });
  }

  Future<int> newContactRaw(ContactsModel newContact) async {
    final id = newContact.id;
    final contact = newContact.contact;
    final phone = newContact.phone;
    final mobil = newContact.mobil;
    final addres = newContact.addres;
    final nicks = newContact.nicks;

    final db = await database;
    final res = await db.rawInsert('''
      INSERT INTO Contacts (id, label, date, priority, notification)
          VALUES($id, $contact, $phone, $mobil, $addres, $nicks)
      ''');
    return res;
  }

  Future<int> newErrandRaw(ErrandModel newErrand) async {
    final id = newErrand.id;
    final label = newErrand.label;
    final status = newErrand.status;
    final date = newErrand.date;
    final priority = newErrand.priority;
    final notification = newErrand.notification;
    final observation = newErrand.observation;

    final db = await database;
    final res = await db.rawInsert('''
      INSERT INTO Agenda (id, label, date, priority, notification)
          VALUES($id, $label, $status, $date, $priority, $notification, $observation)
      ''');
    return res;
  }

  Future<int> newContact(ContactsModel newContact) async {
    final db = await database;
    final res = await db.insert('Contacts', newContact.toJson());
    return res;
  }

  Future<int> newErrand(ErrandModel newErrand) async {
    final db = await database;
    final res = await db.insert('Agenda', newErrand.toJson());
    return res;
  }

  Future<ContactsModel> getContactById(int id) async {
    final db = await database;
    final res = await db.query('Contacts', where: 'id = ?', whereArgs: [id]);
    if (res.isNotEmpty) {
      return ContactsModel.fromJson(res.first);
    } else {
      return ContactsModel(
          contact: 'empty',
          phone: 0,
          mobil: 0,
          addres: 'empty',
          nicks: 'empty');
    }
  }

  Future<ErrandModel> getErrandById(int id) async {
    final db = await database;
    final res = await db.query('Agenda', where: 'id = ?', whereArgs: [id]);
    if (res.isNotEmpty) {
      return ErrandModel.fromJson(res.first);
    } else {
      return ErrandModel(
          label: 'empty',
          status: 0,
          date: 'empty',
          priority: '1',
          notification: 'false',
          observation: 'empty');
    }
  }

  Future<List<ContactsModel>> getAllContacts() async {
    final db = await database;
    final res = await db.query('Contacts');
    if (res.isNotEmpty) {
      return res.map((e) => ContactsModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<List<ErrandModel>> getAllErrands() async {
    final db = await database;
    final res = await db.query('Agenda');
    if (res.isNotEmpty) {
      return res.map((e) => ErrandModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<List<ErrandModel>> getErrandsByStatus(int status) async {
    final db = await database;
    final res = await db.rawQuery('''
      SELECT * FROM Agenda WHERE status = '$status'
    ''');
    if (res.isNotEmpty) {
      return res
          .map((e) => ErrandModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      return [];
    }
  }

  Future<int> updateErrand(ErrandModel currentErrand) async {
    final db = await database;
    final res = await db.update('Agenda', currentErrand.toJson(),
        where: 'id = ?', whereArgs: [currentErrand.id]);
    // final res = await db.rawUpdate(sql)
    return res;
  }

  Future<int> updateContact(ContactsModel currentContact) async {
    final db = await database;
    final res = await db.update('Contacts', currentContact.toJson(),
        where: 'id = ?', whereArgs: [currentContact.id]);
    // final res = await db.rawUpdate(sql)
    return res;
  }

  Future<int> deleteErrand(int id) async {
    final db = await database;
    final res = await db.delete('Agenda', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteContact(int id) async {
    final db = await database;
    final res = await db.delete('Contacts', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllErrands() async {
    final db = await database;
    final res = await db.rawDelete('''
      DELETE FROM Agenda
    ''');
    return res;
  }

  Future<int> deleteAllContacts() async {
    final db = await database;
    final res = await db.rawDelete('''
      DELETE FROM Contacts
    ''');
    return res;
  }

  Future<int> deleteErrandsByStatus(int status) async {
    final db = await database;
    final res = await db.rawDelete('''
      DELETE FROM Agenda WHERE type = '$status'
    ''');
    return res;
  }
}
