import 'package:food_app/database/table_object/setting_detail_table.dart';
import 'package:food_app/shared/config.dart';

class SettingDetail {

  int id;
  int userId;
  int shiftId;
  int connectionStatus;
  int loginStatus;
  int registerStatus;

  SettingDetail(
      {this.userId, this.shiftId, this.connectionStatus, this.loginStatus, this.registerStatus});

  SettingDetail.fromJson(Map<String, dynamic> json){
    this.id = json[SettingDetailTable.id];
    this.userId = json[SettingDetailTable.userId];
    this.connectionStatus = json[SettingDetailTable.connectionStatus];
    this.loginStatus = json[SettingDetailTable.loginStatus];
    this.shiftId = json[SettingDetailTable.shiftId];
    this.registerStatus = json[SettingDetailTable.registerStatus];
  }

  Map<String, dynamic> toMap(SettingDetail settingDetail) {
    return {
      SettingDetailTable.id: settingDetail.id,
      SettingDetailTable.userId: settingDetail.userId,
      SettingDetailTable.connectionStatus: settingDetail.connectionStatus,
      SettingDetailTable.loginStatus: settingDetail.loginStatus,
      SettingDetailTable.shiftId: settingDetail.shiftId,
      SettingDetailTable.registerStatus : settingDetail.registerStatus
    };
  }

  Future<int> insertSettingDetail({SettingDetail settingDetail}) async {
    int res = await Config.database.insert(
        SettingDetailTable.tableName, toMap(settingDetail));
    return res > 0 ? res : -1;
  }

  Future<int> updateSettingDetail(
      {SettingDetail settingDetail, String where, List<
          dynamic> whereArgs}) async {
    int res = await Config.database.update(
        SettingDetailTable.tableName, toMap(settingDetail), where: where,
        whereArgs: whereArgs);
    return res > 0 ? res : -1;
  }

  Future<SettingDetail> getUserSettingByDesc() async{
    SettingDetail settingDetail;
    List<Map<String, dynamic>> resultMap = await Config.database.rawQuery('SELECT * FROM ${SettingDetailTable.tableName} WHERE ${SettingDetailTable.loginStatus} = 0 ORDER BY ${SettingDetailTable.id} DESC');
    if(resultMap.length > 0){
      settingDetail = SettingDetail.fromJson(resultMap[0]);
    } else settingDetail = null;
    return settingDetail;
  }
}


































