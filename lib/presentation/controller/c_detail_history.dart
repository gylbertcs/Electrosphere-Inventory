import 'package:electrosphereinventory/data/model/history.dart';
import 'package:get/get.dart';
import '../../data/source/source_history.dart';

class CDetailHistory extends GetxController {
  final Rx<History> _data = History().obs;
  History get data => _data.value;
  setData(String idHistory) async {
    _data.value = await SourceHistory.getWhereId(idHistory);
    update();
  }

  

}

