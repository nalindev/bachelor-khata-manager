import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class API_Manager {
  Future getdata(String user, String pass) async {
    var validate;

    final response = await http.get(Uri.https('api.igsavers.com', 'api/auth/$user/$pass'));

    //print(response.body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      validate = convert.jsonDecode(response.body);
    } else {
      throw Exception('Failed to connect with the server');
    }

    return validate;
  }

  Future getdash(String user) async{
    var data;

    final response = await http.get(Uri.https('api.igsavers.com', 'api/data/$user'));

    if(response.statusCode == 200 || response.statusCode == 400){
      data = convert.jsonDecode(response.body);
    } else {
      throw Exception('Failed to connect with server');
    }

    return data;
  }
}
