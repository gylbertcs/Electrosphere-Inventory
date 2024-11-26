import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:electrosphereinventory/config/api.dart';
import 'package:electrosphereinventory/config/app_request.dart';
import 'package:electrosphereinventory/config/session.dart';
import '../model/user.dart';

class SourceUser {
static Future<int> count() async {
    String url = '${Api.user}/${Api.count}';
    String? responseBody = await AppRequest.gets(url);
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      return result['data'];
    }
    return 0;
  }

  static Future<bool> login(String email, String password) async {
    String url = '${Api.user}/login.php';
    String? responseBody = await AppRequest.post(url,{
      'email' : email,
      'password' : password,
    });
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']){
        DMethod.printTitle('SourceUser - login','Success');
        Map<String, dynamic> userMap = result['data'];
        Session.saveUser(User.fromJson(userMap));
      } else {
        DMethod.printTitle('SourceUser - login','Failed');
      }
      return result['success'];
    }
    return false;
  }
}
