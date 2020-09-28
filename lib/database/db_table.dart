import 'package:food_app/shared/config.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

class Table {
  //VARIABLES
  String tableName;
  List<String> _listOfColumnsName;
  List<String> _listOfColumnsTypes;
  Database _database;

  Logger _log = Config.log;

  //INITIALIZING VARIABLES IN CONSTRUCTOR
  Table(
      {Database database,
      String tableName,
      List<String> listOfColumnsName,
      List<String> listOfColumnsTypes}) {
    this._database = database;
    this.tableName = tableName;
    this._listOfColumnsName = listOfColumnsName;
    this._listOfColumnsTypes = listOfColumnsTypes;
  }

  //CREATE TABLE
  Future<void> createTable() async {
    await _database.execute(_getTableQuery());
    _log.v('Table $tableName created successfully.');
  }

  //DROP TABLE
  Future<void> dropTable() async {
    await _database.execute(getDropTableQuery());
    _log.v('Table $tableName dropped successfully.');
    ;
  }

  //DELETING A TABLE
  void deleteTable() async => _database
      .delete(this.tableName)
      .whenComplete(() => _log.i('Table $tableName deleted successfully.'))
      .catchError((e) => _log.e('Error on deleteTable.', [e]));

  //GENERATING QUERY
  String _getTableQuery() {
    String query = 'CREATE TABLE IF NOT EXISTS $tableName (';
    for (int i = 0; i < _listOfColumnsName.length; i++) {
      query += '${_listOfColumnsName[i]} ${_listOfColumnsTypes[i]},';
    }
    query = query.substring(0, query.length - 1);
    query += ');';
    return query;
  }

  Future<List<Map<String, dynamic>>> getDataFromDatabase() {
    return _database.query(tableName);
  }

  Future<bool> insertIntoDatabase(List<String> values) async =>
      await _database.insert(tableName, _convertToMap(values)) > 0
          ? true
          : false;

  Map<String, dynamic> _convertToMap(List<String> values) {
    try {
      Map<String, dynamic> map = new Map<String, dynamic>();
      print(_listOfColumnsName.length);
      print(values.length);
      for (int i = 1; i < _listOfColumnsName.length; i++) {
        print(i);
        print(_listOfColumnsName[i + 1]);
        print(values[i]);
        map[_listOfColumnsName[i]] = values[i - 1];
      }
      return map;
    } catch (e) {
      Config.log.e('Error on convertToMap', [e]);
      return null;
    }
  }

  //GENERATING DROP TABLE QUERY
  String getDropTableQuery() => 'DROP TABLE IF EXISTS ${this.tableName}';
}
