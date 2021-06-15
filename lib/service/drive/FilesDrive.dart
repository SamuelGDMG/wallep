import 'dart:async';
import 'dart:io';

import 'package:finance/database/AppDatabase.dart';
import 'package:finance/service/drive/GoogleAuthClient.dart';
import 'package:finance/service/user/user_firebase.dart';
import 'package:finance/state/StateSystem.dart';
import 'package:finance/utils/Constants.dart';
import 'package:finance/utils/StorageUtil.dart';
import 'package:get/get.dart';
import 'package:googleapis/drive/v3.dart' as dr;

import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as directoryPath;

class FilesDrive {

  UserFirebase _userFirebase = UserFirebase();

  Future? getFileId() async {
    final authHeaders = await _userFirebase.getAuthHeaders();

    if(authHeaders != null){
      final authenticateClient = GoogleAuthClient(authHeaders);

      final drive = dr.DriveApi(authenticateClient);

      try{
        final response = await drive.files.list(q: "name='${Constants.DIR_DRIVE}.db'");

        return response.files != null && response.files!.length > 0 ? response.files!.single.id : '';
      }catch(e){
        return null;
      }
    }

    return null;
  }

  //You need create a file first and after that you can update
  Future uploadFile({idFile = ''}) async {
    final authHeaders = await _userFirebase.getAuthHeaders();

    if(authHeaders != null){
      final authenticateClient = GoogleAuthClient(authHeaders);

      final drive = dr.DriveApi(authenticateClient);

      dr.File fileToUpload = dr.File();

      final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();

      final dbPath = directoryPath.join(appDocumentDir.path, '${Constants.DIR_DRIVE}.db');

      var file = File(dbPath);

      fileToUpload.name = '${Constants.DIR_DRIVE}.db';

      if(idFile == ''){
        var response = await drive.files.create(
          fileToUpload,
          uploadMedia: dr.Media(file.openRead(), file.lengthSync()),
        );

        await StorageUtil.putString(Constants.KEY_ID_File_DRIVE, response.id!);

      }else{
        var response = await drive.files.update(fileToUpload, idFile, uploadMedia: dr.Media(file.openRead(), file.lengthSync()));
      }

    }
  }

  Future downloadFile(idFile) async {
    final authHeaders = await _userFirebase.getAuthHeaders();

    if(authHeaders != null){
      final authenticateClient = GoogleAuthClient(authHeaders);

      final drive = dr.DriveApi(authenticateClient);

      final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
      final dbPath = directoryPath.join(appDocumentDir.path, '${Constants.DIR_DRIVE}.db');
      List<int> dataStore = [];

      dynamic file = await drive.files.get(idFile, downloadOptions: dr.DownloadOptions.fullMedia);

      file.stream.listen((data) {
        dataStore.insertAll(dataStore.length, data);
      }, onDone: () async {
        await deleteFileLocal();

        final saveFile = File(dbPath);
        await saveFile.writeAsBytes(dataStore);

        await AppDatabase.instance.reloadDataBase();
      }, onError: (error) {
      });

    }
  }

  Future deleteFileLocal() async {
    try {
      final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
      final dbPath = directoryPath.join(appDocumentDir.path, '${Constants.DIR_DRIVE}.db');

      final file = File(dbPath);

      await file.delete();
    } catch (e) {
      print(e);
    }
  }

}