import 'package:get/get.dart';

class SignUpController extends GetxController {
  final RxString loginType = "LoginIn".obs;
  final RxInt selectedIndex = 0.obs;
  final RxString dropdownValue = "Node".obs;

  void updateLoginType(String newType, int newIndex) {
    loginType.value = newType;
    selectedIndex.value = newIndex;
  }
}
