import 'dart:convert';

import 'package:electrosphereinventory/config/api.dart';
import 'package:electrosphereinventory/config/app_request.dart';

import '../model/history.dart';
//import 'package:electrosphereinventory/presentation/page/inout/inout_page.dart';

class SourceInOut {
  static Future<int> count(String type) async {
    String url = '${Api.inout}/${Api.count}';
    String? responseBody = await AppRequest.post(url,{'type':type});
    Map result = jsonDecode(responseBody!);
    return result['data'];
      // ignore: dead_code
      return 0;
  }
  
 

    static Future<Map<String, dynamic>> analysis(String type) async {
    String url = '${Api.inout}/analysis.php';
    String? responseBody = await AppRequest.post(url,{
      'type': type,
      'today': DateTime.now().toIso8601String(),
    });
    Map result = jsonDecode(responseBody!);
    if (result['success']) {
     //List list = result['data'];
      return {
        'list_total' : result['list_total'],
        'data': result['data'],
      };
    }
    return {
      'list_total' : [0,0,0,0,0,0,0],
      'data' : [],
    };
      
  }

static Future<bool> add({
  required String listProduct,
  required String type,
  required String totalPrice,
}) async {
  String url = '${Api.inout}/${Api.add}';
  String? responseBody = await AppRequest.post(url, {
    'list_product': listProduct,
    'type': type,
    'total_price': totalPrice,
  });
  if (responseBody != null) {
    Map result = jsonDecode(responseBody);
    return result['success'];
  }
  return false;
}

static Future<List<History>> gets(int page, String type) async {
  String url = '${Api.inout}/${Api.gets}';
  String? responseBody = await AppRequest.post(url, {'page': '$page', 'type': type});
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
  String url = '${Api.inout}/${Api.search}';
  String? responseBody = await AppRequest.post(
    url, 
    {'date': query,'type': type},
    );
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
}

