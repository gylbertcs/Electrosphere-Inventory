import 'dart:convert';

import 'package:d_info/d_info.dart';
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
    String? responseBody = await AppRequest.post(url, {
      'email': email,
      'password': password,
    });
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        DMethod.printTitle('SourceUser - login', 'Success');
        Map<String, dynamic> userMap = result['data'];
        Session.saveUser(User.fromJson(userMap));
      } else {
        DMethod.printTitle('SourceUser - login', 'failed');
      }
      return result['success'];
    }

    return false;
  }

  static Future<List<User>> gets() async {
    String url = '${Api.user}/${Api.gets}';
    String? responseBody = await AppRequest.gets(url);
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        List list = result['data'];
        return list.map((e) => User.fromJson(e)).toList();
      }
      return [];
    }
    return [];
  }

  static Future<bool> add(String name, String email, String password) async {
    String url = '${Api.user}/${Api.add}';
    String? responseBody = await AppRequest.post(url, {
      'name': name,
      'email': email,
      'password': password,
    });
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        return true;
      } else {
        if (result['message'] == 'email') {
          DInfo.toastError('Email is already used');
        }
        return false;
      }
    }

    return false;
  }

  static Future<bool> delete(String idUser) async {
    String url = '${Api.user}/${Api.delete}';
    String? responseBody = await AppRequest.post(url, {'id_user': idUser});
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      return result['success'];
    }
    return false;
  }

  static Future<bool> changePassword(String idUser, String newPassword) async {
    String url = '${Api.user}/change_password.php';
    String? responseBody = await AppRequest.post(
      url,
      {'id_user': idUser, 'password': newPassword},
    );
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      return result['success'];
    }
    return false;
  }
}
