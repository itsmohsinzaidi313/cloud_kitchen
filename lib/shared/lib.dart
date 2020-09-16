import 'package:food_app/database/project_database.dart';
import 'package:sqflite/sqflite.dart';

class Lib {

  //GET DATABASE INSTANCE
  Future<Database> getDatabase() => ProjectDatabase().database;
}