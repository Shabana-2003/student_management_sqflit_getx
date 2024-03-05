import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_management/db/database.dart';
import 'package:student_management/model/student_model.dart';
import 'package:student_management/view/widgets/delete_dialog.dart';
import 'package:student_management/view/student_edit.dart';

class StudentDetailsController extends GetxController {
  
  //AddStudentController data = Get.find();
  late DatabaseHelper db;

  @override
  void onInit() {
    super.onInit();
    db = DatabaseHelper();
  }

  void deleteStudent(Student student) {
    Get.defaultDialog(
      title: 'Delete Student',
      content: const Text(
        'Are you sure you want to delete this student?',
        style: TextStyle(color: Colors.white),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      titlePadding: const EdgeInsets.only(top: 25, bottom: 10),
      titleStyle: const TextStyle(color: Colors.white),
      middleTextStyle: const TextStyle(color: Colors.white),
      backgroundColor: const Color.fromARGB(255, 57, 57, 57),
      onConfirm: () {
        Get.snackbar(
          'Success',
          'Student added successfully',
          messageText: const Text(
            'Student Deleted Successfully',
            style: TextStyle(color: Colors.white),
          ),
          titleText: const Text(
            'Deleted',
            style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 17),
          ),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
          isDismissible: true,
        );
        db.deleteStudent(student.id);
        Get.until((route) => Get.currentRoute == '/HomeScreen');
      },
      onCancel: () {
        Get.back();
      },
    );
  }

  void editStudent(Student student) {
    Get.to(() => EditStudentScreen(student: student))?.then((_) => Get.back());
  }

  void showCustomDialog(Student student){
    Get.dialog(DeleteDialog (onCancel: () {
      Get.back();
    },onDelete: () {
      Get.snackbar(
          'Success',
          'Student added successfully',
          messageText: const Text(
            'Student Deleted Successfully',
            style: TextStyle(color: Colors.white),
          ),
          titleText: const Text(
            'Deleted',
            style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 17),
          ),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          snackStyle: SnackStyle.FLOATING,
          backgroundColor: Colors.black,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
          isDismissible: true,
        );
        
        db.deleteStudent(student.id);
        Get.until((route) => Get.currentRoute == '/HomeScreen');
    }));
  }
}
