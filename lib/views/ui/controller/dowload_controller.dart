import 'package:get/get.dart';

class DownloadController extends GetxController {
  final RxBool loading = false.obs;

  void updatePageIndex(bool newValue) {
    loading.value = newValue;
    print("Index value = ${loading.value}");
  }
}
