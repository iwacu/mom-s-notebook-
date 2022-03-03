// ignore_for_file: unused_element

import 'dart:io';

import 'package:momnotebook/models/baby.dart';
import 'package:momnotebook/models/babyTask.dart';
import 'package:momnotebook/models/respopnse.dart';
import 'package:momnotebook/models/timer.dart';
import 'package:momnotebook/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documensDirectory = await getApplicationDocumentsDirectory();
    String path = join(documensDirectory.path, 'momnotebook.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user(
        id INTEGER PRIMARY KEY,
        name TEXT,
        baby_id INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE baby(
        id INTEGER PRIMARY KEY,
        picture TEXT,
        name TEXT,
        sex TEXT,
        birthDay TEXT,
        premature INTEGER,
        relationship TEXT 
      )
    ''');
    await db.execute('''
      CREATE TABLE timer(
        id INTEGER PRIMARY KEY,
        task INTEGER,
        start_time TEXT,
        h INTEGER,
        m INTEGER,
        s INTEGER,
        notes TEXT
         
      )
    ''');
    await db.execute('''
      CREATE TABLE babyTask(
        id INTEGER PRIMARY KEY,
        baby_id INTEGER,
        task_name TEXT,
        time_stamp TEXT,
        note TEXT,
        start_time TEXT,
        end_time TEXT,
        resume_time TEXT,
        qty_food TEXT,
        qty_left TEXT,
        qty_right TEXT,
        qty_feeder TEXT,
        left_breast INTEGER,
        right_breast INTEGER,
        food_group TEXT,
        pee INTEGER,
        poo INTEGER,
        durationH TEXT,
        durationM TEXT,
        durationS TEXT,
        color TEXT,
        on_task_complete INTEGER
         
      )
    ''');
  }

  // read user tbl
  Future<Response<User>> getUser() async {
    Database db = await instance.database;
    var res = await db.query("user", where: "id = ?", whereArgs: [1]);
    return Response(
        object: res.isNotEmpty ? User.fromMap(res.first) : null,
        message: 'success',
        error: false);
  }

  // read baby tbl
  Future<Response<Baby>> getBaby(int id) async {
    Database db = await instance.database;
    var res = await db.query("baby", where: "id = ?", whereArgs: [id]);
    return Response(
        object: res.isNotEmpty ? Baby.fromMap(res.first) : null,
        error: false,
        message: 'success');
  }

  // update baby tbl
  Future<int> updateBaby(Baby baby) async {
    Database db = await instance.database;
    return await db
        .update('baby', baby.toMap(), where: 'id = ?', whereArgs: [baby.id]);
  }

  // ready babies
  Future<List<Baby>> getBabies() async {
    Database db = await instance.database;
    var response = await db.query('baby', orderBy: 'id');
    List<Baby> babies = response.isNotEmpty
        ? response.map((c) => Baby.fromMap(c)).toList()
        : [];
    return babies;
  }

  // update user_table
  Future<int> updateUser(User user) async {
    Database db = await instance.database;

    var res = await db
        .update('user', user.toMap(), where: "id = ?", whereArgs: [user.id]);
    return res;
  }

  // read timer tbl
  Future<Response<Timerr>> getTimerr(int id) async {
    Database db = await instance.database;
    var res = await db.query("timer", where: "task = ?", whereArgs: [id]);
    return Response(
        object: res.isNotEmpty ? Timerr.fromMap(res.first) : null,
        message: 'success',
        error: false);
  }

  // ready babytasks
  Future<List<BabyTask>> getBabyTasks(int id) async {
    Database db = await instance.database;
    var response = await db.query('babyTask',
        where: "baby_id = ?", whereArgs: [id], orderBy: 'id DESC');
    List<BabyTask> babyTasks = response.isNotEmpty
        ? response.map((c) => BabyTask.fromMap(c)).toList()
        : [];
    return babyTasks;
  }

  // insert into user tbl
  Future<int> addUser(User user) async {
    Database db = await instance.database;
    var io = await db.insert('user', user.toMap());
    return io;
  }

  // delete record
  Future<int> deleteRecord(int id) async {
    Database db = await instance.database;
    // await db.execute("delete from " + "timer");
    return await db.delete("timer", where: "task = ?", whereArgs: [id]);
  }

  // insert into timer tbl
  Future<int> addTimer(Timerr timerr) async {
    Database db = await instance.database;

    return await db.insert('timer', timerr.toMap());
  }

  // insert into baby tbl
  Future<int> addBaby(Baby baby) async {
    Database db = await instance.database;
    return await db.insert('baby', baby.toMap());
  }

  // insert into babyTask tbl
  Future<int> addBabyTask(BabyTask babyTask) async {
    Database db = await instance.database;
    return await db.insert('babyTask', babyTask.toMap());
  }

  // update babyTask tbl
  Future<int> updateBabytask(BabyTask babyTask) async {
    Database db = await instance.database;
    return await db.update('babyTask', babyTask.toMap(),
        where: 'id = ?', whereArgs: [babyTask.id]);
  }

  // remove babyTask from tbl
  Future<int> removeBabytask(int id) async {
    Database db = await instance.database;
    return await db.delete('babyTask', where: 'id = ?', whereArgs: [id]);
  }

  // drop table
  drop() async {
    Database db = await instance.database;
    await db.execute("DROP TABLE IF EXISTS user");
    await db.execute("DROP TABLE IF EXISTS baby");
  }
}
