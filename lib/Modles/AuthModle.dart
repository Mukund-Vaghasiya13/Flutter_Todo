class Auth{
  String? data;
  String? messag;
  bool? success;

  Auth({this.data,this.messag,this.success});

 factory Auth.fromjson(Map<String,dynamic> e){
    return Auth(
      data: e["data"],
      messag: e["message"],
      success: e["success"]
    );
 }

}