import 'package:electrosphereinventory/data/model/history.dart';
import 'package:electrosphereinventory/data/source/source_history.dart';
import 'package:get/get.dart';

class CHistory extends GetxController {
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
  getList() async{
    _fetchData.value = true;
    update();

    List<History> newList = await SourceHistory.gets(page);
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

  refreshList() {
    _list.value.clear();
    _page.value = 1;
    _hasNext.value = true;
    getList();
  }

  @override
  void onInit() {
    getList();
    super.onInit();
  }
}

