import 'package:flutter/material.dart';

class StudentDisciplineCasePage extends StatefulWidget {
  const StudentDisciplineCasePage({super.key});

  @override
  State<StudentDisciplineCasePage> createState() => _StudentDisciplineCasePageState();
}

class _StudentDisciplineCasePageState extends State<StudentDisciplineCasePage> {

    void navigateToAddStudentDisciplineCasePage() {
      Navigator.pushReplacementNamed(context, '/add_student_case_page');
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[800],
        title: const Text('Student Discipline Case'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddStudentDisciplineCasePage,
        backgroundColor: Colors.deepPurple[800],
        child: const Icon(Icons.add),
      )
    );
  }
}