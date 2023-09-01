import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:newiet/views/ui/controller/node_global_stuff.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class FirestoreStory extends GetxController {
  var filearray = [].obs;
  var nodeGlobal = Get.find<NodeGlobalStuff>();
  Future<List<String>> uploadFileToStorage(File file) async {
    final storageRef = firebase_storage.FirebaseStorage.instance.ref();

    // Extract the filename from the File object
    final filePath = file.path;
    final List<String> pathParts = filePath.split('/');
    final extractedFileName = pathParts.last;

    final uploadTask =
        storageRef.child('uploads/$extractedFileName').putFile(file);

    await uploadTask.whenComplete(() => null);

    final downloadURL =
        await storageRef.child('uploads/$extractedFileName').getDownloadURL();

    return [downloadURL, extractedFileName];
  }

  Future<void> updateRandomUsers(
      int dis, String downloadURL, String fileName, String email) async {
    final firestore = FirebaseFirestore.instance;
    final random = Random();

    // Query users whose current_files is less than max_file_limit
    final querySnapshot = await firestore
        .collection('users')
        .where('current_files', isLessThan: 3)
        .get();

    // Shuffle the documents to select dis random users
    final usersList = querySnapshot.docs.toList()..shuffle(random);

    for (int i = 0; i < dis; i++) {
      final userDoc = usersList[i];
      fileName = fileName.split(".")[0];
      await firestore.collection('users').doc(userDoc.id).update({
        'requested_files.$fileName': downloadURL,
        'current_files': userDoc['current_files'] + 1,
      });
      await firestore.collection('users').doc(email).update({
        'list_of_files': FieldValue.arrayUnion([fileName]),
      });

      await firestore.collection('users').doc(email).update({
        'peers.$fileName': FieldValue.arrayUnion([userDoc.id]),
      });
    }
  }

  uploadAndDistribute(int dis, String email, File file) async {
    final res = await uploadFileToStorage(file);
    await updateRandomUsers(dis, res[0], res[1], email);
  }

  Future<void> checkAndDownloadFiles(String userId) async {
    final firestore = FirebaseFirestore.instance;
    final storage = FirebaseStorage.instance;
    final userDoc = firestore.collection('users').doc(userId);

    try {
      // Get the user's document to access request_files
      final userSnapshot = await userDoc.get();
      if (!userSnapshot.exists) {
        print('User document does not exist.');
        return;
      }

      final requestFilesMap = userSnapshot.data()?['requested_files'];

      if (requestFilesMap != null && requestFilesMap.isNotEmpty) {
        final downloadedFiles = <String>[];

        // Download each file in request_files
        for (final entry in requestFilesMap.entries) {
          final fileName = entry.key;
          final downloadUrl = entry.value;

          final Reference ref = storage.refFromURL(downloadUrl);
          final fileData = await ref.getData();

          // Get the local directory for saving the file
          final appDocDirectory = await getApplicationDocumentsDirectory();
          final localFilePath = '${appDocDirectory.path}/$fileName';

          // Save the downloaded file to the local device
          final file = File(localFilePath);
          await file.writeAsBytes(fileData!.toList());

          filearray.add(file);
          nodeGlobal.currentFiles.value += 1;
          nodeGlobal.currentSize.value += file.lengthSync();
          OpenFile.open(localFilePath);

          // Save the downloaded file, you can save it to local storage or process it as needed.
          // In this example, we're just keeping track of the downloaded filenames.
          downloadedFiles.add(fileName);
        }

        // Update contain_files with the downloaded filenames
        await userDoc.update({
          'contain_files': FieldValue.arrayUnion(downloadedFiles),
          'requested_files': {}, // Clear request_files
        });

        print('Files downloaded and updated successfully.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<String> getValueForKeyInDocument(String email, String key) async {
    final firestore = FirebaseFirestore.instance;
    final documentReference = firestore.collection('users').doc(email);

    final documentSnapshot = await documentReference.get();

    if (documentSnapshot.exists) {
      final data = documentSnapshot.data();

      if (data != null && data['peers'] is Map<String, dynamic>) {
        final peersMap = data['peers'] as Map<String, dynamic>;
        if (peersMap.containsKey(key)) {
          final value = peersMap[key] as List<String>;
          return value[0];
        }
      }
    }
    return '';
  }

  Future<int> findStringIndexInArray(String userId, String searchString) async {
    final firestore = FirebaseFirestore.instance;
    final userDoc = firestore.collection('users').doc(userId);

    final userSnapshot = await userDoc.get();

    if (userSnapshot.exists) {
      final data = userSnapshot.data();

      if (data != null && data['contain_files'] is List<dynamic>) {
        final containFiles = data['contain_files'] as List<dynamic>;

        // Use listIndexOf to find the index of the searchString in the array
        final index = containFiles.indexOf(searchString);

        // Return the index or -1 if not found
        return index != -1 ? index : 0;
      }
    }
    return 0;
  }

  downloadFile(
      {String fileName = "IMG-20230901-WA0001",
      String email = "testtest@mail.com"}) async {
    final Reference ref =
        FirebaseStorage.instance.ref().child('uploads/$fileName.jpg');
    final temp = await ref.getDownloadURL();
    // Get the local directory for saving the file

    await Permission.manageExternalStorage.request();
    final response = await http.get(Uri.parse(temp));
    if (response.statusCode == 200) {
      final directory = await getExternalStorageDirectory();
      final parentDirectory = Directory('${directory!.path}/Downloads');
      if (!parentDirectory.existsSync()) {
        parentDirectory.createSync(recursive: true);
      }
      final filePath = '${directory!.path}/Downloads/$fileName.jpg';

      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      print('File downloaded to: $filePath');
      OpenFile.open(filePath);
    } else {
      throw Exception('Failed to download file');
    }
  }
}
