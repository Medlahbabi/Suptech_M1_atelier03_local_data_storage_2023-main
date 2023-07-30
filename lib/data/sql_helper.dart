import 'dart:io';

import 'package:atelier03_local_data_storage/models/note.dart';
import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlHelper {
  final String colID = 'id';
  final String colName = 'name';
  final String colDate = 'date';
  final String colNotes = 'notes';
  final String colPosition = 'position';
  final String tableNotes = 'notes';
  static Database? _db;
  final int version = 1;

  static SqlHelper _singleton = SqlHelper._internal();
  SqlHelper._internal();
  factory SqlHelper() {
    return _singleton;
  }

  Future<Database> init() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String dbPath = join(dir.path, 'notes.db');
    Database dbNotes =
        await openDatabase(dbPath, version: version, onCreate: _createDb);
    return dbNotes;
  }

  Future _createDb(Database db, int version) async {
    String query =
        'CREATE TABLE $tableNotes ($colID INTEGER PRIMARY KEY, $colName TEXT, $colDate TEXT, $colNotes TEXT, $colPosition INTEGER)';
    await db.execute(query);
  }

  Future<List<Note>> getNotes() async {
    _db ??= await init();
    List<Map<String, dynamic>> notesList =
        await _db!.query(tableNotes, orderBy: colPosition);
    List<Note> notes = [];
    notesList.forEach((element) {
      notes.add(Note.fromMap(element));
    });
    return notes;
  }

  Future<int> insertNote(Note note) async {
    int result = await _db!.insert(tableNotes, note.toMap());
    return result;
  }

  Future<int> updateNote(Note note) async {
    int result = await _db!.update(tableNotes, note.toMap(),
        where: '$colID = ?', whereArgs: [note.id]);
    return result;
  }

  Future<int> deleteNote(Note note) async {
    int result = await _db!
        .delete(tableNotes, where: '$colID = ?', whereArgs: [note.id]);
    return result;
  }
}
