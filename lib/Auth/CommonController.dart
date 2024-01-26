import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  String? error;
  String? lable;
  String? title;
  TextEditingController value;


  FormTextField({this.error,this.lable,this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        label: Text(lable ?? "N/A"),
        hintText: title ?? "N/A",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            width: 1.5,
            color: Colors.black
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            width: 2,
            color: Colors.greenAccent
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            width: 2,
            color: Colors.black
          ),
        ),
      ),
      controller: value,
      validator: (value) {
        if(value!.isEmpty){
          return error!;
        }
        return null;
      },
    );
  }
}