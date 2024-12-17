import 'dart:convert';

import 'package:electrosphereinventory/config/api.dart';
import 'package:electrosphereinventory/config/app_request.dart';
import 'package:electrosphereinventory/data/model/history.dart';

class SourceHistory {
  static Future<int> count() async {
    String url = '${Api.history}/${Api.count}';
    String? responseBody = await AppRequest.gets(url);
    Map result = jsonDecode(responseBody);
    return result['data'];
      return 0;
  }

  static Future<List<History>> gets(int page) async {
    String url = '${Api.history}/${Api.gets}';
    String? responseBody = await AppRequest.post(url,{
      'page':'$page'
    });
    Map result = jsonDecode(responseBody);
    if (result['success']) {
      List list = result['data'];
      return list.map((e)=> History.fromJson(e)).toList();
    }
    return [];
      return [];
  }

    static Future<List<History>> search(String query) async {
    String url = '${Api.history}/${Api.search}';
    String? responseBody = await AppRequest.post(url,{
      'date':query
    });
    Map result = jsonDecode(responseBody);
    if (result['success']) {
      List list = result['data'];
      return list.map((e)=> History.fromJson(e)).toList();
    }
    return [];
      return [];
  }
}


