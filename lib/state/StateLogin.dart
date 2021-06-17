import 'package:connectivity/connectivity.dart';
import 'package:finance/Dialogs/DialogAlert.dart';
import 'package:finance/Dialogs/DialogSignOut.dart';
import 'package:finance/Dialogs/DialogSynchronizing.dart';
import 'package:finance/database/AppDatabase.dart';
import 'package:finance/database/CategoryDao.dart';
import 'package:finance/database/CreditCardDao.dart';
import 'package:finance/database/MonthSalaryDao.dart';
import 'package:finance/database/SimpleRegisterDao.dart';
import 'package:finance/routes/app_pages.dart';
import 'package:finance/service/drive/FilesDrive.dart';
import 'package:finance/service/user/user_firebase.dart';
import 'package:finance/utils/Constants.dart';
import 'package:finance/utils/StorageUtil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StateLogin extends GetxController {

  UserFirebase _userFirebase = UserFirebase();
  final Connectivity _connectivity = Connectivity();

  bool isUserAuth(){
    return _userFirebase.isUserOn();
  }

  Future loginWithGoogle() async {

    FilesDrive filesDrive = FilesDrive();

    final connection = await getConnectivity();

   try{
     var response = await _userFirebase.signInWithGoogle();
     if(response == null){
       Get.dialog(
         DialogAlert(message: 'tryAgainMsg'.tr, icon: Icons.error_outline,),
       );
     }else if (!connection){
       Get.dialog(
         DialogAlert(message: 'noNetwork'.tr, icon: Icons.network_wifi,),
       );
     } else{
       Get.dialog(
           DialogSynchronizing(),
         barrierDismissible: false
       );
       var responseDrive = await filesDrive.getFileId();

       if(responseDrive != null && responseDrive != ''){
         await StorageUtil.putString(Constants.KEY_ID_File_DRIVE, responseDrive);

         await filesDrive.downloadFile(responseDrive);

         Get.offAllNamed(Routes.HOME);
       }else{
         final getIdFile = StorageUtil.getString(Constants.KEY_ID_File_DRIVE);

         if(getIdFile != ''){
           await StorageUtil.putString(Constants.KEY_ID_File_DRIVE, '');
         }

         Get.offAllNamed(Routes.HOME);
       }
     }

   }catch(e){
     Get.dialog(
       DialogAlert(message: 'tryAgainMsg'.tr, icon: Icons.error_outline,),
     );
   }

  }

  Future signOut() async {

    final connection = await getConnectivity();

    if(connection){
      try{
        Get.dialog(
            DialogSynchronizing(upload: true,),
            barrierDismissible: false
        );
        await readyToUploadFile();

        await readyToSignOut();
      }catch(e){
        Get.back();
        Get.dialog(
          DialogSignOut(message: 'signOutErrorSavingFileOnDrive'.tr, icon: Icons.error_outline,),
        );
      }
    }else{
      Get.dialog(
        DialogSignOut(message: 'signOutNoNetWorking'.tr, icon: Icons.wifi_off,),
      );
    }

  }

  Future signingOutWithoutSaveOnDrive() async {
    await readyToSignOut();
  }

  Future readyToSignOut() async {
    await Future.wait([
      SimpleRegisterDao().clearWholeStore(),
      MonthSalaryDao().clearWholeStore(),
      CategoryDao().clearWholeStore(),
      CreditCardDao().clearWholeStore()
    ]);

    await _userFirebase.signOut();

    Get.offAllNamed(Routes.LOGIN);
  }

  Future<bool> getConnectivity() async {
    ConnectivityResult  connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){
      return true;
    }

    return false;
  }

  Future readyToUploadFile() async {
      final getIdFile = StorageUtil.getString(Constants.KEY_ID_File_DRIVE);
      FilesDrive filesDrive = FilesDrive();

      await filesDrive.uploadFile(idFile: getIdFile);
  }

  Future uploadFile() async {

    final connection = await getConnectivity();

    if(connection){
      Get.dialog(
          DialogSynchronizing(upload: true,),
          barrierDismissible: false
      );
      try{
        await readyToUploadFile();
        Get.back();
        Get.dialog(
          DialogAlert(message: 'dialogUploadFileSuccess'.tr, icon: Icons.check,),
        );
      }catch(e){
        Get.back();
        Get.dialog(
          DialogAlert(message: 'tryAgainMsg'.tr, icon: Icons.error_outline,),
        );
      }
    }else{
      Get.dialog(
        DialogAlert(message: 'noNetwork'.tr, icon: Icons.wifi_off,),
      );
    }
  }



}