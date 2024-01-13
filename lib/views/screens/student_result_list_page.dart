import 'package:flutter/material.dart';

class StudentResultPage extends StatefulWidget {
  const StudentResultPage({super.key});

  @override
  State<StudentResultPage> createState() => _StudentResultPageState();
}

class _StudentResultPageState extends State<StudentResultPage> {

    void navigateToAddStudentResultPage() {
      Navigator.pushReplacementNamed(context, '/add_student_result_page');
      }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[800],
        title: const Text('Student Result'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddStudentResultPage,
        backgroundColor: Colors.deepPurple[800],
        child: const Icon(Icons.add),
      )
    );
  }
}