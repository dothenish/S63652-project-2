/*=====================================================
* Program: main.dart
* Purpose: Main program to run the School Management App
* Notes: define routes, call onBoardingPage()
*======================================================
*/
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:school_management_app/data/teachers_list_page.dart';
import 'package:school_management_app/data/students_list_page.dart';
import 'views/screens/add_teacher_page.dart';
import 'views/screens/dashboard_page.dart';
import 'views/screens/on_boarding_page.dart';
import 'views/screens/log_in_page.dart';
import 'views/screens/add_student_page.dart';
import 'views/screens/add_studresult_page.dart';


//connect project with firebase
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid ? await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyA8vuOJQ9AHVlZplgNWwPmjA48o4wyw5FI', 
      appId: '1:841598331217:android:708c8d0838b561c7074b70', 
      messagingSenderId: '841598331217', 
      projectId: 'flutter-school-managemen-d72cf'
      )) 
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'School Management App',
      //defining route for the app
      initialRoute: '/onboarding',
      routes: {
        '/onboarding':(context) => const OnBoardingPage(),
        '/loginpage':(context) => const LoginPage(),
        '/dashboard':(context) => const Dashboard(),
        '/add_student_page':(context) => const AddStudentPage(),
        '/add_teacher_page':(context) => const AddTeacherPage(),
        '/teachers_list_page':(context) => const TeachersList(),
        '/students_list_page':(context) => const StudentsList(),
        'add_studresult_page':(context) => AddStudResultPage(onAddResult: (subject , grade) {})
        
      },
      home: const LoginPage(),
    );
  }
}
