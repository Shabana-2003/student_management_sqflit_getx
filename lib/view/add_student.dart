import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management/controller/add_controller.dart';
import 'dart:io';
import 'package:student_management/core/constrains.dart';
import 'package:student_management/db/database.dart';
import 'package:student_management/model/student_model.dart';
import 'package:student_management/view/widgets/save_button.dart';


// ignore: must_be_immutable
class AddStudentScreen extends StatelessWidget {
  final AddStudentController controller = Get.put(AddStudentController());
  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _schoolnameController = TextEditingController();
  final _fathernameController = TextEditingController();

  DatabaseHelper databaseHelper = DatabaseHelper();

  AddStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Students",
          style: titletxt,
        ),
        backgroundColor: primaryclr,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: () async {
                  XFile? img = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  controller.updateProfilePicturePath(img!.path);

                },
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: const Color.fromARGB(255, 57, 57, 57),
                  backgroundImage:
                      controller.profilePicturePath.value.isNotEmpty
                          ? FileImage(File(controller.profilePicturePath.value ))
                          : null,
                  child: controller.profilePicturePath.value.isEmpty
                      ? const Icon(
                          Icons.add_a_photo,
                          size: 35,
                        )
                      : null,
                ),
              ),
              
              kheight20,
              TextFormField(
                controller: _nameController,
                onChanged: controller.updateName,
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
                controller: _schoolnameController,
                onChanged: controller.updateSchoolName,
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
                controller: _fathernameController,
                onChanged: controller.updateFatherName,
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
                controller: _ageController,
                onChanged: (value) => controller.updateAge(value),
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
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              kheight40,
              Savebutton(
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    final name = controller.name.value;
                    final school = controller.schoolName.value;
                    final father = controller.fatherName.value;
                    final age = controller.age.value;

                    final student = Student(
                      id: 0,
                      name: name,
                      schoolname: school,
                      fathername: father,
                      age: age,
                      profilePicture: controller.profilePicturePath.value,
                    );
                    controller.clearImage();
                    databaseHelper.insertStudent(student).then((id) {
                      if (id > 0) {
                        Get.back();

                        controller.saveStudent();
                      } else {
                        Get.snackbar(
                          'Failed',
                          'Failed to add student',
                          backgroundColor: Colors.red,
                          snackPosition: SnackPosition.TOP,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 3),
                        );
                      }
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
