class ErrorMaster{

  String id;
  String className;
  String dateTime;
  String title;

  ErrorMaster({this.id, this.className, this.dateTime, this.title});

  ErrorMaster.fromJson(Map<String, dynamic> json){
    this.id = json['id'];
    this.className = json['class_name'];
    this.dateTime = json['date_time'];
    this.title = json['title'];
  }
}