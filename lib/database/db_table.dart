import 'package:food_app/shared/config.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

class Table {
  //VARIABLES
  String _tableName;
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
    this._tableName = tableName;
    this._listOfColumnsName = listOfColumnsName;
    this._listOfColumnsTypes = listOfColumnsTypes;
  }

  //CREATE TABLE
  void createTable() async {
    await _database.execute(getTableQuery());
    _log.i('Table $_tableName created successfully.');
  }

  //DROPPING A TABLE
  void dropTable() async {
    await _database
        .execute(getDropTableQuery())
        .whenComplete(() => _log.i('Table $_tableName dropped successfully.'))
        .catchError((e) => _log.e('Error on dropTable.'));
    ;
  }

  //DELETING A TABLE
  void deleteTable() async => _database
      .delete(this._tableName)
      .whenComplete(() => _log.i('Table $_tableName deleted successfully.'))
      .catchError((e) => _log.e('Error on deleteTable.', [e]));

  //GENERATING QUERY
  String getTableQuery() {
    String query = 'CREATE TABLE IF NOT EXISTS $_tableName (';
    for (int i = 0; i < _listOfColumnsName.length; i++) {
      query += '${_listOfColumnsName[i]} ${_listOfColumnsTypes[i]},';
    }
    query = query.substring(0, query.length - 1);
    query += ');';
    return query;
  }

  //GENERATING DROP TABLE QUERY
  String getDropTableQuery() => 'DROP TABLE IF EXISTS ${this._tableName}';
}
