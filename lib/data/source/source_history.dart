import 'dart:convert';

import 'package:electrosphereinventory/config/api.dart';
import 'package:electrosphereinventory/config/app_request.dart';
import 'package:electrosphereinventory/data/model/history.dart';

class SourceHistory {
  static Future<int> count() async {
    String url = '${Api.history}/${Api.count}';
    String? responseBody = await AppRequest.gets(url);
    if(responseBody !=null){
      Map result = jsonDecode(responseBody);
      return result['data'];
  }
      return 0;
  }

static Future<List<History>> gets(int page) async {
  String url = '${Api.history}/${Api.gets}';
  String? responseBody = await AppRequest.post(url, {'page': '$page'});
  if (responseBody != null) {
    Map result = jsonDecode(responseBody);
    if (result['success']) {
      List list = result['data'];
      return list.map((e) => History.fromJson(e)).toList();
    }
    return [];
  }
  return [];
}


   static Future<List<History>> search(String query, String type) async {
  String url = '${Api.history}/${Api.search}';
  String? responseBody = await AppRequest.post(url, {'date': query});
  if (responseBody != null) {
    Map result = jsonDecode(responseBody);
    if (result['success']) {
      List list = result['data'];
      return list.map((e) => History.fromJson(e)).toList();
    }
    return [];
  }
  return [];
}

static Future<Object> getWhereId(String id) async {
  String url = '${Api.history}/where_id.php';
  String? responseBody = await AppRequest.post(url, {'id_history': id});
  if (responseBody != null) {
    Map result = jsonDecode(responseBody);
    if (result['success']) {
      return History.fromJson(result['data']);
    }
    return [];
  }
  return [];
}

static Future<bool> delete(String idHistory async {
    String url = '${Api.history}/delete_where_id.php';
    String? responseBody = await AppRequest.post(url,{
      'id_history' : idHistory});
  if (responseBody != null) {
    Map result = jsonDecode(responseBody);
    return result['success'];
}
      return false;
  }

  static Future<bool> deleteAllBeforeDate(String date) async {
    String url = '${Api.product}/delete_all_before_date.php';
    String? responseBody = await AppRequest.post(url,{'date' : date});
  if (responseBody != null) {
    Map result = jsonDecode(responseBody);
    return result['success'];
}
      return false;
  }

}
