import 'package:flutter/material.dart';
import 'package:todo/Auth/CommonController.dart';

class SinupView extends StatelessWidget {
  TextEditingController _controllerUsername = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  Widget spacer = SizedBox(
    height: 20,
  );

  GlobalKey<FormState> Key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sin Up",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)
          ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child:Form(
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
                      title: "Sinup",
                      constraints: constraints,
                      Onclick: () {
                        if(Key.currentState!.validate()){
                        print("Working");
                       }
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
