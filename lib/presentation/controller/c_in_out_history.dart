import 'package:electrosphereinventory/data/model/history.dart';
import 'package:electrosphereinventory/data/source/source_history.dart';
import 'package:get/get.dart';

import '../../data/source/source_inout.dart';

class CInOutHistory extends GetxController {
  // final RxBool _loading = false.obs;
  // bool get loading => _loading.value;

  final RxBool _fetchData = false.obs;
  bool get fetchData => _fetchData.value;

  final RxBool _hasNext = true.obs;
  bool get hasNext => _hasNext.value;

  final RxInt _page = 1.obs;
  int get page => _page.value;

  final RxList<History> _list = <History>[].obs;
  List<History> get list => _list.value;
  getList(String type) async{
    _fetchData.value = true;
    update();

    List<History> newList = await SourceInOut.gets(page,type);
    _list.value.addAll(newList);

    if (newList.length < 10) _hasNext.value = false;
    _page.value = page + 1;

    _fetchData.value = false;
    update();
  }

  search(String query) async {
    _list.value = await SourceHistory.search(query);
    update();
  }
}

