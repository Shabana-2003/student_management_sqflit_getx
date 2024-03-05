import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_management/controller/homecontroller.dart';
import 'package:student_management/core/constrains.dart';
import 'package:student_management/view/add_student.dart';
import 'package:student_management/view/student_details.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  final HomeController controller = Get.put(HomeController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryclr,
        title: TextField(
          style: const TextStyle(color: Colors.white),
          onChanged: (query) {
            controller.filterStudents(query);
          },
          decoration: const InputDecoration(
            hintText: 'Search student here',
            border: InputBorder.none,
            hintStyle: TextStyle(
              color: Colors.white70,
              fontFamily: 'Comfortaa',
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              controller.toggleSearch();
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Obx(() {
        return controller.filteredStudents.isEmpty
            ? const SingleChildScrollView(
                child: Column(
                  children: [
                    kheight40,
                    kheight40,
                    Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Image(image: AssetImage("lib/img/studentimg.png")),
                    ),
                    Text(
                      'No students found.',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          letterSpacing: 4,
                          wordSpacing: 5),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: controller.filteredStudents.length,
                itemBuilder: (context, index) {
                  final student = controller.filteredStudents[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(StudentDetailspage(student: student))!
                          .then((value) => controller.refreshStudentList());
                    },
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: Card(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Color.fromARGB(255, 82, 82, 82)),
                            height: 80,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      FileImage(File(student.profilePicture)),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      student.name,
                                      style: const TextStyle(
                                          overflow: TextOverflow.fade,
                                          fontFamily: 'Comfortaa',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19),
                                    ),
                                    // const SizedBox(height: 5,),
                                    //  Text( 'Age : ${student.age.toString()}',
                                    //   style: const TextStyle(

                                    //     fontWeight: FontWeight.w600,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),
                  );
                },
              );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddStudentScreen())!
              .then((value) => controller.refreshStudentList());
        },
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
