import 'package:get/get.dart';

class CAddInout extends GetxController {

        final RxList<Map> _list = <Map>[].obs;
        List<Map> get list => _list.value;
        add(newData) async {
          _list.value.add(newData);
          update();
        }
      delete(Map data){
        _list.value.remove(data);
          update();
      }

  
    
}


