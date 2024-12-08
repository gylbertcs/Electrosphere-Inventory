import 'dart:convert';

import 'package:electrosphereinventory/config/api.dart';
import 'package:electrosphereinventory/config/app_request.dart';
//import 'package:electrosphereinventory/presentation/page/inout/inout_page.dart';

class SourceInOut {
  static Future<int> count(String type) async {
    String url = '${Api.inout}/${Api.count}';
    String? responseBody = await AppRequest.post(url,{'type':type});
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      return result['data'];
    }
    return 0;
  }

    static Future<Map<String, dynamic>> analysis(String type) async {
    String url = '${Api.inout}/analysis.php';
    String? responseBody = await AppRequest.post(url,{
      'type': type,
      'today': DateTime.now().toIso8601String(),
    });
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
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
  
    return {
      'list_total' : [0,0,0,0,0,0,0],
      'data' : [],
    };
  }
}
