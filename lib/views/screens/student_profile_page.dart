import 'package:flutter/material.dart';
import 'package:school_management_app/models/student.dart';
//import 'add_studresult_page.dart';
//import 'add_disciplinecase_page.dart';

class StudentProfilePage extends StatefulWidget {
  final Student student;
  final Function(Student) onRemoveStudent;

  const StudentProfilePage({
    super.key, 
    required this.student,
    required this.onRemoveStudent});

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
  
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  // List<String> results = [];
  // List<String> disciplinecase = [];

      void navigateToStudentResultListPage() {
      Navigator.pushReplacementNamed(context, '/students_result_list_page');
      }

      void navigateToStudentDisciplineCaseListPage() {
      Navigator.pushReplacementNamed(context, '/students_disciplinecase_list_page');
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
                  color: Colors.purple[50]
                ),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Student Name \n${widget.student.name}',
                  style: const TextStyle(
                    fontSize: 20
                  ),),
                  const SizedBox(height: 10),
                  Text('Identification Number \n${widget.student.icNo}',
                  style: const TextStyle(
                    fontSize: 20
                  ),),
                  const SizedBox(height: 10),
                  Text('Class \n${widget.student.className}',
                  style: const TextStyle(
                    fontSize: 20
                  )),
            
                  const SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //crossAxisAlignment: ,
                    children: [
                      ElevatedButton(
                        onPressed: navigateToStudentResultListPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)
                            ),
                        ),
                        child: const Text("View Result")),
                      ElevatedButton(
                        onPressed: navigateToStudentDisciplineCaseListPage, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)
                            ),
                        ),
                        child: const Text('View Discipline Case')
                      )
                    ],
                  ),
                  const SizedBox(height: 200),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () {_showDeleteConfirmationDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)
                            ),
                        ),
                        child: const Text('Delete Student Profile',
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic
),
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

  //   void _showAddResultPage(BuildContext context) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (ctx) => AddStudResultPage(
  //         onAddResult: (subject, grade) {
  //           setState(() {
  //             results.add('$subject: $grade');
  //           });
  //         },
  //       ),
  //     ),
  //   );
  // }

  //     void _showAddDisciplineCasePage(BuildContext context) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (ctx) => AddDisciplineCasePage(
  //         onAddCase: (title, desc) {
  //           setState(() {
  //             disciplinecase.add('$title: $desc');
  //           });
  //         },
  //       ),
  //     ),
  //   );
  // }

void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Student?'),
          content: const Text('Are you sure you want to delete this student?'),
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
                widget.onRemoveStudent(widget.student);
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Pop twice to go back to the student list
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}