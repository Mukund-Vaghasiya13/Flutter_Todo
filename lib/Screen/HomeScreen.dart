import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/Auth/Login.dart';

class Home extends StatefulWidget {
  String token;
  Home({required this.token});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo",
          style: TextStyle(
            fontSize: 20,
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
         }, icon: Icon(Icons.exit_to_app))
        ],
      ),
    );
  }
}
