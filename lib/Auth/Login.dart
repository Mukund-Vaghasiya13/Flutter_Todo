import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/Auth/CommonController.dart';
import 'package:todo/Auth/Register.dart';
import 'package:todo/Modles/ApiService.dart';
import 'package:todo/Modles/AuthModle.dart';
import 'package:todo/Screen/HomeScreen.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  SharedPreferences? pref;
  TextEditingController _controllerUsername = TextEditingController();

  TextEditingController _controllerPassword = TextEditingController();

  Widget spacer = SizedBox(
    height: 20,
  );

  GlobalKey<FormState> Key = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    IsUserLoginorNot();
  }


  void IsUserLoginorNot()async{
   pref = await SharedPreferences.getInstance();
   var a =  pref!.getString("token");
   if(a != null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home(token: a,)));
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Form(
          key: Key,
          child: LayoutBuilder(builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth > 800
                  ? constraints.maxWidth / 2.2
                  : constraints.maxWidth / 1.2,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FormTextField(
                      lable: "Username",
                      title: "Enter Username",
                      error: "Invalid Username",
                      value: _controllerUsername,
                    ),
                    spacer,
                    FormTextField(
                      lable: "password",
                      title: "Enter Password",
                      error: "Invalid password",
                      value: _controllerPassword,
                    ),
                    spacer,
                    MyButton(
                      title: "Login",
                      constraints: constraints,
                      Onclick: ()async {
                       if(Key.currentState!.validate()){
                         var response = await ApiHandler.Post("https://todo-xiii.onrender.com/api/todo/v1/login", {
                          "username": _controllerUsername.value.text,
                          "password": _controllerPassword.value.text
                        },null);

                        var data = Auth.fromjson(response);
                        if(data.success ?? false){
                         pref!.setString("token", data.data!);
                         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home(token: data.data!,)));
                        }

                       }
                      },
                    ),
                    spacer,
                    Text("Or",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),),
                    spacer,
                    MyButton(
                      title: "Sinup",
                      constraints: constraints,
                      Onclick: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SinupView()));
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
