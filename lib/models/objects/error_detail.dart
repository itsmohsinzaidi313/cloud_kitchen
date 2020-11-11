class ErrorDetail{

  String id;
  String errorMasterId;
  String error;

  ErrorDetail({this.id, this.errorMasterId, this.error});

  ErrorDetail.fromJson(Map<String, dynamic> json){
    this.id = json['id'];
    this.errorMasterId = json['error_master_id'];
    this.error = json['error'];
  }
}