import 'package:electrosphereinventory/data/source/source_history.dart';
import 'package:electrosphereinventory/data/source/source_inout.dart';
import 'package:electrosphereinventory/data/source/source_user.dart';
import 'package:get/get.dart';
import 'package:electrosphereinventory/data/source/source_product.dart';

class CDashboard extends GetxController {
  final RxInt _product = 0.obs;
  int get product => _product.value;
  setProduct() async {
    _product.value = await SourceProduct.count();
  }

  final RxInt _history = 0.obs;
  int get history => _history.value;
  setHistory() async {
    _history.value = await SourceHistory.count();
  }

  final RxInt _in = 0.obs;
  int get ins => _in.value;
  setIn() async {
    _in.value = await SourceInOut.count('IN');
  }

  final RxInt _out = 0.obs;
  int get outs => _out.value;
  setOut() async {
    _out.value = await SourceInOut.count('OUT');
  }

  final RxInt _employee = 0.obs;
  int get employee => _employee.value;
  setEmployee() async {
    _employee.value = await SourceUser.count();
  }

  @override
  void onInit(){
    setProduct();
    setHistory();
    setIn();
    setOut();
    setEmployee();
    super.onInit();
  }
}

