class ErrorMessageModel {
  final int statusCode;
  final String statusMessage;
  bool success;

  ErrorMessageModel(this.statusCode, this.statusMessage,this.success);

  factory ErrorMessageModel.fromJson(Map<String,dynamic> json){
    return ErrorMessageModel(json['status_code'], json["status_message"],json["success"] );
  }
}