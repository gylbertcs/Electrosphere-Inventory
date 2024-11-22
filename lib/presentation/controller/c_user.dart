import 'package:get/get.dart';
import '../../data/model/user.dart';

class CUser extends GetxController {
  final Rx<User> _data = User().obs;
  User get data => _data.value;
  set data(User newData) {
    data = newData;
  }
}
