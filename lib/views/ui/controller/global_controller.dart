import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalController extends GetxController {
  var role = 'Node'.obs;

  // Function to save the 'role' variable to SharedPreferences
  Future<void> saveRoleToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', role.value);
  }

  // Function to retrieve the 'role' variable from SharedPreferences
  Future<void> loadRoleFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    role.value = prefs.getString('role') ??
        'Node'; // Use 'Node' as the default value if 'role' is not found
  }
}
