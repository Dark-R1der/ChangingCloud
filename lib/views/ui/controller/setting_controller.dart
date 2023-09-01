import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingController extends GetxController {
  var fileLimit = 20.obs;
  var bandwidth = 2.obs;

  var budget = 2000.obs;

  var peers = 1.obs;
  var currentFiles = 0.obs;

  var fileSizeLimit = 20.obs;

  var currentLimit = 0.obs;

  var allocated = 0.obs;

  // Function to save variables to SharedPreferences
  Future<void> saveToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('fileLimit', fileLimit.value);
    await prefs.setInt('bandwidth', bandwidth.value);
    await prefs.setInt('budget', budget.value);
    await prefs.setInt('peers', peers.value);
    await prefs.setInt('currentFiles', currentFiles.value);
    await prefs.setInt('fileSizeLimit', fileSizeLimit.value);
    await prefs.setInt('currentLimit', currentLimit.value);
    await prefs.setInt('allocated', allocated.value);
  }

  // Function to retrieve variables from SharedPreferences
  Future<void> loadFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    fileLimit.value = prefs.getInt('fileLimit') ?? fileLimit.value;
    bandwidth.value = prefs.getInt('bandwidth') ?? bandwidth.value;
    budget.value = prefs.getInt('budget') ?? budget.value;
    peers.value = prefs.getInt('peers') ?? peers.value;
    currentFiles.value = prefs.getInt('currentFiles') ?? currentFiles.value;
    fileSizeLimit.value = prefs.getInt('fileSizeLimit') ?? fileSizeLimit.value;
    currentLimit.value = prefs.getInt('currentLimit') ?? currentLimit.value;
    allocated.value = prefs.getInt('allocated') ?? allocated.value;
  }
}
