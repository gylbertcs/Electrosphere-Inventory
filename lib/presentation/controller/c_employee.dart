
import 'package:get/get.dart';

import '../../data/model/user.dart';
import '../../data/source/source_user.dart';


class CEmployee extends GetxController {
        final RxBool _loading = false.obs;
        bool get loading =>_loading.value;
        set loading(bool newData) {
          _loading.value = newData;
        }

        final RxList<User> _list = <User>[].obs;
        List<User> get list => _list;
        setList() async {
          loading = true;
          update();
          _list.value = await SourceUser.gets();
          update();
          Future.delayed(const Duration(seconds: 1),(){
          loading = false;
          update(); 
        });
      } 

 
    
      @override
      void onInit() {
        setList();
        super.onInit();
      }
}


