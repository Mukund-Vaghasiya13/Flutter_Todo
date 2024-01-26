import 'package:flutter/material.dart';
import 'package:todo/Auth/CommonController.dart';

class LoginView extends StatelessWidget {
  TextEditingController _controllerUsername = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  Widget spacer = SizedBox(
    height: 20,
  );

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
                      Onclick: () {
                        print("working");
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
                        print("working");
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

class MyButton extends StatelessWidget {
  BoxConstraints constraints;
  Function() Onclick;
  String? title;
  MyButton({required this.Onclick, required this.constraints,this.title});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        // splashColor: Colors.white,
        onTap: Onclick,
        child: Container(
          child: Center(
            child: Text(
              title!,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          height: 55,
          width: constraints.maxWidth > 800
              ? constraints.maxWidth / 2.2
              : constraints.maxWidth / 1.2,
        ),
      ),
    );
  }
}
