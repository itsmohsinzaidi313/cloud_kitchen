import 'dart:async';
import 'package:food_app/database/columns.dart';
import 'package:food_app/database/columns_types.dart';
import 'package:food_app/database/db_table.dart';
import 'package:food_app/database/tables.dart';
import 'package:food_app/shared/config.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProjectDatabase {
  //VARIABLES
  static const String databaseName = Config.databaseName;
  static int currentVersion;
  static const int newVersion = 0;
  static Database _database;

  //LOGGER
  static Logger _log = Config.log;

  //LIST
  static List<Table> tablesList = [];

  Future<Database> get database async {
    if (_database != null) {
      currentVersion = await _database.getVersion();
      return _database;
    } else {
      return _initDatabase();
    }
  }

  DATABASE status = Config.databaseVersion;
  Future<Database> _initDatabase() async {
    String databaseLocation = await getDatabasesPath();
    String path = join(databaseLocation, Config.databaseName);
    _database = await openDatabase(path);
    currentVersion = await _database.getVersion();
    _log.i('CURRENT DATABASE VERSION: $currentVersion');
    openDatabase(path,
        onCreate: onCreate(_database, currentVersion),
        onUpgrade: onUpgrade(_database, newVersion, currentVersion),
        onDowngrade: onDowngrade(_database, newVersion, currentVersion));
    return _database;
  }

  void truncate(Database db) {
    tablesList.forEach((table) => table.deleteTable());
  }

  FutureOr<void> onCreate(Database db, int version) {
    if (status == DATABASE.CREATE) {
      _log.i('ENTRY DATABASE onCreate');
      getTables(db)
          .then((value) => value.forEach((table) => table.createTable()));
    }
  }

  FutureOr<void> onUpgrade(Database db, int oldVersion, int newVersion) {
    // ADD UPGRADE INSTRUCTIONS HERE
    if (status == DATABASE.UPGRADE) {
      _log.i('ENTRY DATABASE onUpgrade');
      getTables(db)
          .then((value) => value.forEach((table) => table.dropTable()));
      getTables(db)
          .then((value) => tablesList.forEach((table) => table.createTable()));
    }
  }

  FutureOr<void> onDowngrade(Database db, int oldVersion, int newVersion) {
    // ADD DOWNGRAGE INSTRUCTIONS HERE IF ANY
    if (status == DATABASE.DOWNGRADE) {
      _log.i('ENTRY DATABASE onDowngrade');
      getTables(db)
          .then((value) => value.forEach((table) => table.dropTable()));
      getTables(db)
          .then((value) => tablesList.forEach((table) => table.createTable()));
    }
  }

  static List<Table> _listTables = [];
  static Future<List<Table>> getTables(Database db) async {
    if (_listTables.length == 0) {
      for (int i = 0; i < Tables.listofAllTables.length; i++) {
        _listTables.add(new Table(
            database: db,
            tableName: Tables.listofAllTables[i],
            listOfColumnsName: Columns.listofAllColumns[i],
            listOfColumnsTypes: Types.listofAllColumnTypes[i]));
      }
      return _listTables;
    } else {
      return _listTables;
    }
  }
}
