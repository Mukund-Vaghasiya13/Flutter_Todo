import "package:http/http.dart" as http;
import 'dart:convert';
class ApiHandler{
// "https://todo-xiii.onrender.com"
  static Future<dynamic> Post(String url,Map<String,String> body) async{
    var uri = Uri.parse(url);
    var response = await http.post(uri,body: body);
    var jsondata = jsonDecode(response.body);
    
    return jsondata;
  }
}