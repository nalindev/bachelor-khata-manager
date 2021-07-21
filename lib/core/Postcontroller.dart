import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class API_PostManager{

  Future addToAll(var amount, var dis, var user, bool rahul, bool nalin, bool saurav, bool prakshit, bool kshitij) async{
    var data;

    Map value = {
      "money": int.parse(amount),
      "discription": dis,
      "user": user,
      "rahul": rahul,
      "nalin": nalin,
      "saurav": saurav,
      "prakshit": prakshit,
      "kshitij": kshitij
    };
    String body = convert.jsonEncode(value);
    //print(body);

    var url = Uri.parse('https://api.igsavers.com/api/addtoall');
    final response = await http.post(url,headers: {"Content-Type": "application/json"}, body: body);

     //print(response.body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      data = convert.jsonDecode(response.body);
    } else {
      throw Exception('Failed to connect with the server');
    }

    return data;
  }

  Future deleteById(int id) async{
    var data;
    final response = await http.delete(Uri.https('api.igsavers.com', 'api/delete/$id'));

    print(response.body);
    if(response.statusCode == 200 || response.statusCode == 400){
      data = convert.jsonDecode(response.body);
    } else {
      throw Exception('Failed to connect with server');
    }

    return data;
  }

  Future deleteAll(var user, var kisse) async{
    var data;
    final response = await http.delete(Uri.https('api.igsavers.com', 'api/alldelete/$user/$kisse'));

    print(response.body);
    if(response.statusCode == 200 || response.statusCode == 400){
      data = convert.jsonDecode(response.body);
    } else {
      throw Exception('Failed to connect with server');
    }

    return data;
  }

  Future postdata(String name, String kisse, String discription, var money) async {
    var data;

    Map value = {
      "name": name,
      "kisse": kisse,
      "money": int.parse(money),
      "discription": discription
    };
    String body = convert.jsonEncode(value);

    var url = Uri.parse('https://api.igsavers.com/api/add');
    final response = await http.post(url,headers: {"Content-Type": "application/json"}, body: body);

    // print(response.body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      data = convert.jsonDecode(response.body);
    } else {
      throw Exception('Failed to connect with the server');
    }

    return data;
  }
}