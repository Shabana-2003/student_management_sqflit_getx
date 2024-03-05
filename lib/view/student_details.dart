import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_management/controller/detailscontroller.dart';
import 'package:student_management/core/constrains.dart';
import 'dart:io';

import 'package:student_management/model/student_model.dart';



class StudentDetailspage extends StatelessWidget {
  final StudentDetailsController controller =
      Get.put(StudentDetailsController());
  final Student student;

  StudentDetailspage({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile', style: titletxt),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              //controller.deleteStudent(student);
              controller.showCustomDialog(student);
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              controller.editStudent(student);

            },
          ),
        ],
        backgroundColor: primaryclr,
      ),
      body: Column(
        children: [
          kheight,
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(File(student.profilePicture)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kheight,
                 
                  Text(
                    'Name :               ${student.name}',
                    style: contenttxt,
                  ),
                  kheight,
                  Text(
                    'Schoolname :   ${student.schoolname}',
                    style: contenttxt,
                  ),
                  kheight,
                  Text(
                    'Fathername :    ${student.fathername}',
                    style: contenttxt,
                  ),
                  kheight,
                  Text(
                    'Age :                   ${student.age}',
                    style: contenttxt,
                  ),
                  kheight,
                  const SizedBox(
                    width: 63,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
