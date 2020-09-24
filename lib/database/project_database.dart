import 'dart:async';
import 'package:food_app/database/tables.dart';
import 'package:food_app/shared/config.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:food_app/database/db_table.dart';

class ProjectDatabase{

  //VARIABLES
  static const String databaseName = Config.DATABASE_NAME;
  static int currentVersion;
  static const int newVersion = Config.DATABASE_VERSION;
  static Database _database;

  //LOGGER
  static Logger _log = Config.log;

  //LIST
  static List<Table> tablesList = [];

  Future<Database> get database async {
    try{
      getListTables();
    }
    catch(e){
      _log.i('Getting tables list $e');
    }
    if (_database != null) {
      currentVersion = await _database.getVersion();
      return _database;
    } else {
      return _initDatabase();
    }
  }

  Future<Database> _initDatabase() async {
    String databaseLocation = await getDatabasesPath();
    String path = join(databaseLocation, Config.DATABASE_NAME);
    _database = await openDatabase(path);
    currentVersion = await _database.getVersion();
    openDatabase(path,
        onCreate: onCreate(_database, newVersion),
        onUpgrade: onUpgrade(_database, newVersion, currentVersion),
        onDowngrade: onDowngrade(_database, newVersion, currentVersion));
    return _database;
  }


  void create(Database db) {
    _log.v('CREATING DATABASE');
    tablesList.forEach((table) => table.createTable());
  }

  void truncate(Database db) {
    tablesList.forEach((table) => table.deleteTable());
  }

  FutureOr<void> onCreate(Database db, int version) {
    if (version == 0) {
      tablesList.forEach((table) => table.createTable());
    }
  }

  FutureOr<void> onUpgrade(Database db, int oldVersion, int newVersion) {
    // ADD UPGRADE INSTRUCTIONS HERE
    if (oldVersion < newVersion) {
      tablesList.forEach((table) => table.dropTable());
      tablesList.forEach((table) => table.createTable());
    }
  }

  FutureOr<void> onDowngrade(Database db, int oldVersion, int newVersion) {
    // ADD DOWNGRADE INSTRUCTIONS HERE IF ANY
    if (oldVersion > newVersion) {
      tablesList.forEach((table) => table.dropTable());
      tablesList.forEach((table) => table.createTable());
    }
  }

  Future<List<Table>> getListTables() async {
    tablesList = await Tables.getTables();
    return tablesList;
  }
}