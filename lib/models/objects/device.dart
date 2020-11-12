import 'package:food_app/database/table_object/device_table.dart';
import 'package:food_app/shared/config.dart';
import 'package:food_app/shared/lib.dart';
import 'package:sqflite/sqflite.dart';

class Device {

  String id;
  String serverId;
  String outletId;
  String companyId;
  String deviceKey;
  String delStatus;
  String isInstalled;
  String dateAdded;
  String dateModified;

  Device.fromJson(Map<String, dynamic> json)
      : serverId = json['id'],
        outletId = json['outlet_id'],
        companyId = json['company_id'],
        deviceKey = json['device_key'],
        delStatus = json['del_status'],
        isInstalled = json['is_installed'],
        dateAdded = json['date_added'],
        dateModified = json['date_modified'];

  Device(
      {this.serverId,
      this.outletId,
      this.companyId,
      this.deviceKey,
      this.delStatus,
      this.isInstalled,
      this.dateAdded,
      this.dateModified});

  List<String> getList() => [
    this.serverId,
    this.outletId,
    this.companyId,
    this.deviceKey,
    this.delStatus,
    this.isInstalled,
    this.dateAdded,
    this.dateModified
  ];

  Map<String, dynamic> getValues() {
    Map<String, dynamic> map = new Map();
    for (int i = 0; i < getList().length; i++) {
      map[DeviceTable.columnsName[i + 1]] = getList()[i];
    }
    return map;
  }

  Future<bool> insertIntoDatabase(Database db) async =>
      await Lib.insertIntoDatabase(db, DeviceTable.tableName, getValues());

  Future<Device> getDeviceById(int outletId) async{
    Device _device;
    List<Map<String, dynamic>> deviceMap = await Config.database.rawQuery('SELECT * FROM ${DeviceTable.tableName} WHERE ${DeviceTable.outletId} = $outletId');
    if(deviceMap.length > 0){
      _device = Device.fromJson(deviceMap[0]);
    } else _device = null;
    return _device;
  }
}
