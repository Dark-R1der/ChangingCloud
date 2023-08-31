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

  var documentStuff = [].obs;
  var imagesStuff = [].obs;
  var videosStuff = [].obs;
  var audioStuff = [].obs;

  var currentIndex = 0.obs;
  var currentFiles = 0.obs;

  var currentOccupied = 0.obs;

  var currentProject = "".obs;

  var projectNames = [].obs;
  var projectLimit = [].obs;
  var creationDates = [].obs;

  var projectIndex = 0.obs;

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
    await prefs.setStringList("projectLimits",
        projectLimit.map((dynamic item) => item.toString()).toList());
    await prefs.setInt('$currentProject.currentFiles', currentFiles.value);
    await prefs.setStringList('projectsList',
        projectNames.map((dynamic item) => item.toString()).toList());
    await prefs.setStringList('creationDates',
        creationDates.map((dynamic item) => item.toString()).toList());
    await prefs.setInt(
        '$currentProject.currentOccupied', currentOccupied.value);
  }

  Future<void> retrieveFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the string lists
    documentStuff.value =
        prefs.getStringList("$currentProject.documents") ?? [];
    imagesStuff.value = prefs.getStringList("$currentProject.images") ?? [];
    videosStuff.value = prefs.getStringList("$currentProject.videos") ?? [];
    audioStuff.value = prefs.getStringList("$currentProject.audio") ?? [];
    projectNames.value = prefs.getStringList("projectsList") ?? [];
    creationDates.value = prefs.getStringList("creationDates") ?? [];
    individualSizes.value = prefs
            .getStringList("$currentProject.indSizes")
            ?.map((item) => int.parse(item))
            ?.toList() ??
        [0, 0, 0, 0];

    projectLimit.value = prefs
            .getStringList("projectLimits")
            ?.map((item) => int.parse(item))
            ?.toList() ??
        [];

    // Retrieve the integers
    currentFiles.value = prefs.getInt('$currentProject.currentFiles') ?? 0;
    currentOccupied.value =
        prefs.getInt('$currentProject.currentOccupied') ?? 0;
  }

  changeProject(int index) async {
    await saveToSharedPreferences();
    currentProject.value = projectNames[index];
    await retrieveFromSharedPreferences();
  }

  addANewProject(String name, String date, int limit) {
    projectNames.add(name);
    projectLimit.add(limit);
    creationDates.add(date);
  }

  RxList<dynamic> getListFromIndex() {
    if (currentIndex.value == 0) {
      return documentStuff;
    } else if (currentIndex.value == 1) {
      return imagesStuff;
    } else if (currentIndex.value == 2) {
      return audioStuff;
    } else {
      return videosStuff;
    }
  }
}
