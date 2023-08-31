import 'package:get/get.dart';
import 'package:newiet/views/ui/models/project_model.dart';

class OverViewController extends GetxController {
  RxList<ProjectModel> dataList = <ProjectModel>[].obs;

  void addDataItem(String name, double value, DateTime date) {
    final newDataItem = ProjectModel(
      name: name,
      value: value,
      date: date,
    );
    dataList.add(newDataItem);
  }
}
