/*=====================================================
* Program: student_profile_page.dart
* Purpose: display student profile of a specific student
* Notes: have options to navigate to other page to view result & discipline case, delete profile
*======================================================
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management_app/models/student.dart';
import 'package:school_management_app/providers/student_provider.dart';
//import 'add_studresult_page.dart';
//import 'add_disciplinecase_page.dart';

class StudentProfilePage extends StatefulWidget {
  final Student student;
  final Function(Student) onRemoveStudent;

  const StudentProfilePage({
    super.key,
    required this.student,
    required this.onRemoveStudent,
  });

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  // List<String> results = [];
  // List<String> disciplinecase = [];

  void navigateToStudentResultListPage() {
    Provider.of<StudentProvider>(context, listen: false)
        .setStudentId(widget.student.id); //set studentId using StudentProvider
    Navigator.pushReplacementNamed(context, '/students_result_list_page'); 
  }

void navigateToStudentDisciplineCaseListPage() {
    Provider.of<StudentProvider>(context, listen: false)
        .setStudentId(widget.student.id);
    Navigator.pushReplacementNamed(
        context, '/students_disciplinecase_list_page');
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[800],
        title: const Text('Student Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              //color: Colors.purple[50],
              padding: const EdgeInsets.all(16.0),
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.purple[50]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Student Name \n${widget.student.name}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Identification Number \n${widget.student.icNo}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text('Class \n${widget.student.className}',
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 100),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //crossAxisAlignment: ,
                    children: [
                      ElevatedButton( //to student result page
                        onPressed: navigateToStudentResultListPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple[800],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                        ),
                        child: const Text("View Result"),
                      ),

                      ElevatedButton( // to student discipline case page
                          onPressed: navigateToStudentDisciplineCaseListPage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple[800],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                          ),
                          child: const Text('View Discipline Case'))
                    ],
                  ),

                  const SizedBox(height: 200),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            _showDeleteConfirmationDialog(context); //call the dialog box before deleting
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.delete),
                              Text(
                                'Delete Student Profile',
                                style: TextStyle(
                                    fontSize: 18, fontStyle: FontStyle.italic),
                              ),
                            ],
                          )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }


  //function to show dialog box before proceed to delete
  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Student?'),
          content: const Text('Are you sure you want to delete this student?'),
          actions: [

            //when cancel is pressed
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),

            //when delete is pressed
            TextButton( 
              onPressed: () {
                // Call the onRemoveStudent callback to delete the student
                widget.onRemoveStudent(widget.student);
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