import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:student_management/controller/editcontroller.dart';
import 'package:student_management/core/constrains.dart';
import 'package:student_management/db/database.dart';
import 'package:student_management/model/student_model.dart';
import 'package:student_management/view/widgets/save_button.dart';

class EditStudentScreen extends StatelessWidget {
  final EditStudentController controller = Get.put(EditStudentController());
  final Student student;

   EditStudentScreen({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseHelper datahelp = DatabaseHelper();


    controller.initialize(student);

    return Scaffold(
      appBar: AppBar(
        title: const Text(" Edit Students", style: titletxt),
        backgroundColor: primaryclr,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: GetBuilder<EditStudentController>(
          builder: (_) {
            return Form(
              key: _.formKey,
              child: ListView(
                children: [
                  kheight,
                  GestureDetector(
                    onTap: () async {
                      XFile? img = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      _.updateProfilePicturePath(img!.path);
                    },
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: _.profilePicturePath.isNotEmpty
                          ? FileImage(File(_.profilePicturePath as String))
                          : FileImage(File(student.profilePicture)),
                    ),
                  ),
                  kheight20,
                  TextFormField(
                    controller: _.nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: const Text('Student Name'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Student Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  kheight17,
                  TextFormField(
                    controller: _.schoolNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: const Text(' School Name'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter The school Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  kheight17,
                  TextFormField(
                    controller: _.fatherNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: const Text('Father Name'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Father Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  kheight17,
                  TextFormField(
                    controller: _.ageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: const Text('Age'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Age';
                      } else {
                        return null;
                      }
                    },
                  ),
                  kheight20,
                  Savebutton(onTap: () {
                    _.formKey.currentState!.validate();
                    {
                      final name = _.nameController.text;
                      final schoolname = _.schoolNameController.text;
                      final fathername = _.fatherNameController.text;
                      final age = int.parse(_.ageController.text);

                      final updatedStudent = Student(
                        id: student.id,
                        name: name,
                        schoolname: schoolname,
                        fathername: fathername,
                        age: age,
                        profilePicture: _.profilePicturePath.isNotEmpty
                            ? _.profilePicturePath.toString()
                            : student.profilePicture,
                      );

                      datahelp.updateStudent(updatedStudent).then((id) {
                        if (id > 0) {
                          controller.showDialog();
                          // Get.offAll(() => HomeScreen());
                                  Get.until(
                              (route) => Get.currentRoute == '/HomeScreen');

                        } else {
                          Get.showSnackbar(
                            const GetSnackBar(
                              titleText: Text(
                                'Failed',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              messageText: Text(
                                'Failed to update student',
                                style: TextStyle(fontSize: 12),
                              ),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      });
                    }
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
