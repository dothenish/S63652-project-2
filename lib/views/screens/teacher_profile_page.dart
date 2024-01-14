/*=====================================================
* Program: teacher_profile_page.dart
* Purpose: Display details of teacher profile for specific teacher
* Notes: 
*======================================================
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management_app/models/teacher.dart';
import 'package:school_management_app/providers/student_provider.dart';

class TeacherProfilePage extends StatefulWidget {
  final Teacher teacher;
  final Function(Teacher) onRemoveTeacher;

  const TeacherProfilePage(
      {super.key, required this.teacher, required this.onRemoveTeacher});

  @override
  State<TeacherProfilePage> createState() => _TeacherProfilePageState();
}

class _TeacherProfilePageState extends State<TeacherProfilePage> {
  void navigateToEditTeacherProfilePage() {
    Provider.of<StudentProvider>(context, listen: false)
        .setStudentId(widget.teacher.id);
    Navigator.pushReplacementNamed(context, '/edit_teacher_profile_page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[800],
        title: const Text('Teacher Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              height: MediaQuery.of(context).size.height,
              //width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.purple[50]),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Teachers Name \n${widget.teacher.name}',
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 10),
                  Text('Identification Number \n${widget.teacher.icNo}',
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 10),
                  Text(
                    'Teaching Subject \n${widget.teacher.subject}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 100),
                  ElevatedButton(
                      onPressed: () {
                        _showDeleteConfirmationDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0))),
                      child: const Text(
                        'Delete Teacher Profile',
                        style: TextStyle(
                            fontSize: 18, fontStyle: FontStyle.italic),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        navigateToEditTeacherProfilePage();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple[800],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0))),
                      child: const Text(
                        'Edit Teacher Profile',
                        style: TextStyle(
                            fontSize: 18, fontStyle: FontStyle.italic),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Teacher?'),
          content: const Text('Are you sure you want to delete this teacher?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Call the onRemoveStudent callback to delete the student
                widget.onRemoveTeacher(widget.teacher);
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pop(); // Pop twice to go back to the student list
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}