class SettingMaster{

  String id;
  String title;

  SettingMaster({this.id, this.title});

  SettingMaster.fromJson(Map<String, dynamic> json){
    this.id = json['id'];
    this.title = json['title'];
  }
}