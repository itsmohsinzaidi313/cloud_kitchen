import 'package:food_app/shared/config.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

class Table{

  //LOGGER
  static Logger _log = Config.log;

  //VARIABLES
  String _tableName;
  List<String> _listOfColumnsName;
  List<String> _listOfColumnsTypes;
  Database _database;

  //INITIALIZING VARIABLES IN CONSTRUCTOR
  Table({ Database database, String tableName, List<String> listOfColumnsName, List<String> listOfColumnsTypes }) {
      this._database = database;
      this._tableName = tableName;
      this._listOfColumnsName = listOfColumnsName;
      this._listOfColumnsTypes = listOfColumnsTypes;
  }

  //CREATE TABLE
  void createTable() async {
    await _database.execute(getTableQuery());
    _log.i('TABLE $_tableName CREATED SUCCESSFULLY..');
  }

  //DROPPING A TABLE
  void dropTable() async {
    await _database.execute(getDropTableQuery());
    _log.i('TABLE $_tableName DROPPED SUCCESSFULLY..');
  }

  //DELETING A TABLE
  void deleteTable() async {
    await _database.delete(this._tableName);
    _log.i('TABLE $_tableName DELETED SUCCESSFULLY..');
  }

  //GENERATING QUERY
  String getTableQuery() {
    String query = 'CREATE TABLE $_tableName (';
    for (int i = 0; i < _listOfColumnsName.length; i++) {
      if ( i < _listOfColumnsName.length) {
        query += '${_listOfColumnsName[i]} ${_listOfColumnsTypes[i]},';
      }
      else{
        query += '${_listOfColumnsName[i]} ${_listOfColumnsTypes[i]}';
      }
    }
    query += ');';
    return query;
  }

  //GENERATING DROP TABLE QUERY
  String getDropTableQuery() {
    return 'DROP TABLE IF EXISTS ${this._tableName}';
  }

}