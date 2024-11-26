import 'dart:convert';

import 'package:electrosphereinventory/config/api.dart';
import 'package:electrosphereinventory/config/app_request.dart';

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
}
