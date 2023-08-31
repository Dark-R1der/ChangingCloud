import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DownloadManagerController extends GetxController {
  var fileNames = [
    "Documents",
    "Images",
    "Videos",
    "Audio",
  ].obs;

  var individualSizes = [0, 0, 0, 0].obs;

  var documentStuff = [];
  var imagesStuff = [];
  var videosStuff = [];
  var audioStuff = [];

  var currentIndex = 0.obs;
  var currentFiles = 0.obs;

  var currentOccupied = 0.obs;

  var currentProject = "".obs;

  saveToSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("$currentProject.documents",
        documentStuff.map((dynamic item) => item.toString()).toList());
    await prefs.setStringList("$currentProject.images",
        imagesStuff.map((dynamic item) => item.toString()).toList());
    await prefs.setStringList("$currentProject.videos",
        videosStuff.map((dynamic item) => item.toString()).toList());
    await prefs.setStringList("$currentProject.audio",
        audioStuff.map((dynamic item) => item.toString()).toList());
    await prefs.setStringList("$currentProject.indSizes",
        individualSizes.map((int item) => item.toString()).toList());
    await prefs.setInt('$currentProject.currentFiles', currentFiles.value);
    await prefs.setInt(
        '$currentProject.currentOccupied', currentOccupied.value);
  }

  Future<void> retrieveFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the string lists
    documentStuff = prefs.getStringList("$currentProject.documents") ?? [];
    imagesStuff = prefs.getStringList("$currentProject.images") ?? [];
    videosStuff = prefs.getStringList("$currentProject.videos") ?? [];
    audioStuff = prefs.getStringList("$currentProject.audio") ?? [];
    individualSizes.value = prefs
            .getStringList("$currentProject.indSizes")
            ?.map((item) => int.parse(item))
            ?.toList() ??
        [0, 0, 0, 0];

    // Retrieve the integers
    currentFiles.value = prefs.getInt('$currentProject.currentFiles') ?? 0;
    currentOccupied.value =
        prefs.getInt('$currentProject.currentOccupied') ?? 0;
  }

  changeProject(String name) async {
    await saveToSharedPreferences();
    currentProject.value = name;
    await retrieveFromSharedPreferences();
  }
}
