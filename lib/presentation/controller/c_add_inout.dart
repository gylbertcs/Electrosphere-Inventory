import 'dart:convert';

import 'package:d_info/d_info.dart';
import 'package:d_method/d_method.dart';
import 'package:get/get.dart';

import '../../data/source/source_inout.dart';

class CAddInout extends GetxController {
  final RxDouble _totalPrice = 0.0.obs; 
  double get totalPrice => _totalPrice.value;

  final RxList<Map> _list = <Map>[].obs;
  List<Map> get list => _list.toList();

  add(newData) async {
    _list.add(newData);
    double quantity = double.parse(newData['quantity'].toString());
    double price = double.parse(newData['price'].toString());
    _totalPrice.value += quantity * price; 
    update();
  }

  delete(Map data) {
    _list.remove(data);
    double quantity = double.parse(data['quantity'].toString());
    double price = double.parse(data['price'].toString());
    _totalPrice.value -= quantity * price;
    update();
  }

addInOut(String type) async{
                                   
    bool success = await SourceInOut.add(       
      listProduct: jsonEncode(list),
      type: type,
      totalPrice: totalPrice.toStringAsFixed(2),
    );
    if (success) {
      DMethod.printTitle('addinout', 'success');
      DInfo.dialogSuccess('Success Add $type');
      DInfo.closeDialog(
        actionAfterClose: () {
          DMethod.printTitle('addinout', 'close dialog');
          Get.back(result: true);
        }
      );
    } else {
      DInfo.dialogError('Failed Add $type');
      DInfo.closeDialog();

  }
}
}