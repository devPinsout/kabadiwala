
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kabadiwala/utils/colors.dart';

showSuccess({required String title ,required String message}) {
    return Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primaryColor,
      colorText: AppColors.whiteColor,
    );
  }
showError({required String title ,required String message}) {
    return Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.secondaryColor,
      colorText: AppColors.whiteColor,
    );
  }


showProgress({String title =""})
{
  return Get.defaultDialog(
    content: CircularProgressIndicator(
      color: AppColors.primaryColor,
    ),
    title: title,
     titleStyle: TextStyle(fontSize: 15),
  );
}

void closeProgress()
{
  Get.back(closeOverlays: false);
}


// class Snackbar {
//   static void showSnackbar(String title, String message, Color color) {
//     Get.snackbar(
//       title,
//       message,
//       backgroundColor: color,
//       colorText: Colors.white,
//       snackPosition: SnackPosition.BOTTOM,
//       duration: Duration(seconds: 3),
//     );
//   }
// }
