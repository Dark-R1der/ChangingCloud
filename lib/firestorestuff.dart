import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class FirestoreStory {
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
        .where('current_files', isLessThan: 'max_file_limit')
        .get();

    // Shuffle the documents to select dis random users
    final usersList = querySnapshot.docs.toList()..shuffle(random);

    for (int i = 0; i < dis; i++) {
      final userDoc = usersList[i];
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

      final requestFilesMap = userSnapshot.data()?['request_files'];

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

          // Save the downloaded file, you can save it to local storage or process it as needed.
          // In this example, we're just keeping track of the downloaded filenames.
          downloadedFiles.add(fileName);
          final Reference storageRef = storage.ref().child('uploads/$fileName');
          await storageRef.delete();
        }

        // Update contain_files with the downloaded filenames
        await userDoc.update({
          'contain_files': FieldValue.arrayUnion(downloadedFiles),
          'request_files': {}, // Clear request_files
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

  downloadFile(String fileName, String email) async {
    final res = await getValueForKeyInDocument(email, fileName);
    final index = await findStringIndexInArray(res, fileName);
    var downloadLink = "";
    // Upload File to Cloud Storage and get a download link and set t to downloadLink
    final Reference ref = FirebaseStorage.instance.refFromURL(downloadLink);
    final fileData = await ref.getData();

    // Get the local directory for saving the file
    final appDocDirectory = await getApplicationDocumentsDirectory();
    final localFilePath = '${appDocDirectory.path}/$fileName';

    // Save the downloaded file to the local device
    final file = File(localFilePath);
    await file.writeAsBytes(fileData!.toList());
  }
}
