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
// https://todo-xiii.onrender.com/api/todo/v1/Todos/todo/gettodo

class Todo{
  String? id;
  String? refId;
  String? todo;

  Todo({this.id,this.refId,this.todo});

  factory Todo.fromjson(Map<String,dynamic> e){
    return Todo(
      id: e["_id"],
      refId: e["refId"],
      todo: e["todo"]
    );
 }
}