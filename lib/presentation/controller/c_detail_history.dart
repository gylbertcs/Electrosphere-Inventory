import 'package:electrosphereinventory/data/model/history.dart';
import 'package:get/get.dart';
import '../../data/model/user.dart';
import '../../data/source/source_history.dart';

class CDetailHistory extends GetxController {
  final Rx<User> _data = User().obs;
  History get data => _data.value;
  set data(String idHistory) {
    _data.value = await SourceHistory.getWhereId(idHistory);
    update();
  }

  void setData(String idhHistory) {}

}

