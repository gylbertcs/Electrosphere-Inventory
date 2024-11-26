import 'package:d_method/d_method.dart';
import 'package:http/http.dart' as http;

class AppRequest {
  static Future<String?> gets(
   String url, {
   Map<String, String>? headers,
   }) async {
    try {
      var response = await http.get(
        Uri.parse(url), 
        headers: headers,
        );
      DMethod.printTitle('block try request GET', response.body);
      return response.body;
    } catch (e) {
      DMethod.printTitle('block catch request GET', e.toString());
      return null;
    }
   }

   static Future<String?> post(
   String url, 
   Object? data,{
   Map<String, String>? headers,
   }) async {
    try {
      var response = await http.post(
        Uri.parse(url), 
        body: data, 
        headers: headers,
        );
      DMethod.printTitle('block try request POST', response.body);
      return response.body;
    } catch (e) {
      DMethod.printTitle('block catch request POST', e.toString());
      return null;
    }
   }
}