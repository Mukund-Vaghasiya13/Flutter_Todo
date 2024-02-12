
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/Auth/CommonController.dart';
import 'package:todo/Auth/Login.dart';
import 'package:todo/Modles/ApiService.dart';
import 'package:todo/Modles/AuthModle.dart';

class Home extends StatefulWidget {
  String token;
  Home({required this.token});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List? dataLst;
  String? todo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTodo();
  }

  void getTodo()async{
    var response = await ApiHandler.GetData("https://todo-xiii.onrender.com/api/todo/v1/Todos/todo/gettodo", widget.token);
    var data = List.from(response["data"]).map((e)=>Todo.fromjson(e)).toList();
   setState(() {
      dataLst = data;
   });
    print(dataLst ?? "nulllllll lll");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
         IconButton(onPressed: ()async{
          SharedPreferences pref = await SharedPreferences.getInstance();
            pref.remove("token");
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginView()));
         }, icon: Icon(Icons.exit_to_app,size: 40,)),
          IconButton(onPressed: ()async{
            var _token = TextEditingController();
            showDialog(context: context, builder:(context)=>AlertDialog(
                title: Text("Add todo"),
                actions: [
                FormTextField(value: _token,title: "Enter todo",lable: "Todo",),
                ElevatedButton(onPressed: ()async{
                 var response = await ApiHandler.Post("https://todo-xiii.onrender.com/api/todo/v1/Todos/todo/add", {
                    "todo":_token.text,
                  }, widget.token);
                  if(response["success"]){
                    getTodo();
                    _token.text = "";
                    Navigator.of(context).pop(); 
                  }
                }, child: Text("Add"))
                ],
              ));
         }, icon: Icon(Icons.add,size: 40,))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(itemBuilder: (context,i){
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(dataLst![i].todo ?? "",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Expanded(child: SizedBox()),
                  IconButton(onPressed: ()async{
                    var response = await ApiHandler.Post("https://todo-xiii.onrender.com/api/todo/v1/Todos/todo/delete", {"TodoID":dataLst![i].id}, widget.token );
                    if(response["success"]){
                      getTodo();
                    }
                  }, icon: Icon(CupertinoIcons.delete)),
                  IconButton(onPressed: (){
                    var edit = TextEditingController();
                    showDialog(context: context, builder: (context){
                     return AlertDialog(
                        title: Text(dataLst![i].todo,),
                        actions: [
                          FormTextField(value: edit,error: "Enter \"Edit\" Value",lable: "Edit",title: "Enter Value",),
                          ElevatedButton(onPressed: ()async{
                            var response = await ApiHandler.Post("https://todo-xiii.onrender.com/api/todo/v1/Todos/todo/update", {
                              "todo":edit.text,
                              "TodoID":dataLst![i].id
                            }, widget.token);
                            if(response["success"]){
                              getTodo();
                              Navigator.pop(context);
                            }
                          }, child: Text("Edit"))
                        ],
                      );
                    });
                  }, icon: Icon(CupertinoIcons.pencil))
                ],
              ),
            ),
          );
        },itemCount: dataLst?.length ?? 0),
      ),
    );
  }
}
