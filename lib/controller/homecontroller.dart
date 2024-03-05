import 'package:get/get.dart';
import 'package:student_management/db/database.dart';
import 'package:student_management/model/student_model.dart';



class HomeController extends GetxController {
  RxBool isSearching = false.obs;
  RxList<Student> students = <Student>[].obs;
  RxList<Student> filteredStudents = <Student>[].obs;

  late DatabaseHelper databaseHelper;

  @override
  void onInit() {
    super.onInit();
    databaseHelper = DatabaseHelper();
    refreshStudentList();
  }

  Future<void> refreshStudentList() async {
    final studentList = await databaseHelper.getStudents();
    students.assignAll(studentList);
    filteredStudents.assignAll(studentList);
  }

  // ignore: unused_element
  void filterStudents(String query) {
    if (query.isEmpty) {
      filteredStudents.assignAll(students);
    } else {
      filteredStudents.assignAll(students
          .where((student) =>
              student.name.toLowerCase().contains(query.toLowerCase()))
          .toList());
    }
  }

  void toggleSearch() {
    isSearching.toggle();
    if (!isSearching.isTrue) {
      filteredStudents.assignAll(students);
    }
  }
}
