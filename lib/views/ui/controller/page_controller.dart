import 'package:get/get.dart';

class PageControl extends GetxController {
  final RxInt index = 0.obs;

  void updatePageIndex(int newIndex) {
    print("Index value = from the Controll ${index.value}");
    index.value = newIndex;
  }
}
