
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
  var _token = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTodo();
  }

  void getTodo()async{
    var response = await ApiHandler.GetData("https://todo-xiii.onrender.com/api/todo/v1/Todos/todo/gettodo", widget.token);
    var data = List.from(response["data"]).map((e)=>Todo.fromjson(e)).toList();
    dataLst = data;
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
      body: Center(
        child: Column(children: [

        ]),
      ),
    );
  }
}
