/*=====================================================
* Program: main.dart
* Purpose: Main program to run the School Management App
* Notes: define routes, call onBoardingPage()
*======================================================
*/
import 'package:flutter/material.dart';
import 'package:school_management_app/views/widgets/teachers_list.dart';
import 'package:school_management_app/views/widgets/students_list.dart';
import 'views/screens/add_teacher_page.dart';
import 'views/screens/dashboard_page.dart';
import 'views/screens/on_boarding_page.dart';
import 'views/screens/log_in_page.dart';
import 'views/screens/manage_teachers_page.dart';
// 'views/screens/manage_students_page.dart';
import 'views/screens/add_class_page.dart';
import 'views/screens/add_student_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'School Management App',
      //defining route for the app
      initialRoute: '/onboarding',
      routes: {
        '/onboarding':(context) => const OnBoardingPage(),
        '/loginpage':(context) => const LoginPage(),
        '/dashboard':(context) => Dashboard(),
        '/add_class_page':(context) => AddClassPage(),
        '/manage_teachers_page':(context) => ManageTeachersPage(),
        '/add_student_page':(context) => AddStudentPage(),
        '/add_teacher_page':(context) => AddTeacherPage(),
        '/teachers_list_page':(context) => TeachersList(),
        '/students_list_page':(context) => StudentsList()
        
      },
      //The app will first show the onboarding page when the program is being run.
      home: const OnBoardingPage(),
    );
  }
}
