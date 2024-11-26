import 'dart:convert';

import 'package:electrosphereinventory/config/api.dart';
import 'package:electrosphereinventory/config/app_request.dart';

class SourceHistory {
  static Future<int> count() async {
    String url = '${Api.history}/${Api.count}';
    String? responseBody = await AppRequest.gets(url);
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      return result['data'];
    }
    return 0;
  }
}
