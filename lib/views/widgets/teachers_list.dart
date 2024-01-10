import 'package:flutter/material.dart';
import 'package:school_management_app/views/screens/add_teacher_page.dart';

class TeachersList extends StatefulWidget {
  const TeachersList({super.key});

  @override
  State<TeachersList> createState() => _TeachersListState();
}

class _TeachersListState extends State<TeachersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teachers List'),
      ),
    );
  }
}
