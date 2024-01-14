/*=====================================================
* Program: add_studresult_page.dart
* Purpose: Add result for a specific student
* Notes:
*======================================================
*/
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:school_management_app/providers/student_provider.dart';

class AddStudentResultPage extends StatefulWidget {
  const AddStudentResultPage({super.key});

  @override
  State<AddStudentResultPage> createState() => _AddStudentResultPageState();
}

class _AddStudentResultPageState extends State<AddStudentResultPage> {
  final _formKey = GlobalKey<FormState>();
  final subjectController = TextEditingController();
  final gradeController = TextEditingController();
  var _isSending = false;

  void navigateToStudentResultListPage() {
    Navigator.pushReplacementNamed(context, '/students_result_list_page');
  }

  //@override
  void _saveStudentResult() async {
    if (_formKey.currentState!.validate()) { //validate form inputs
      setState(() {
        _isSending = true;
      });
      _formKey.currentState!.save();
      final url = Uri.https(
          'flutter-school-managemen-d72cf-default-rtdb.asia-southeast1.firebasedatabase.app',
          'students-list/${Provider.of<StudentProvider>(context, listen: false).getStudentId}/result.json');

      final response = await http.post( //HTTP POST request to firebase
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'subjectName': subjectController.text,
          'grade': gradeController.text,
        }),
      );

      print(response.body);
      print(response.statusCode);

      final Map<String, dynamic> resData = json.decode(response.body);

      //Check the context for widget NULL
      if (!context.mounted) {
        return;
      }
      Navigator.pop(context);
      // Navigator.of(context).pop(Student(
      //     id: resData['name'],
      //     icNo: icNoController.text.toString(),
      //     className: classNameController.text.toString(),
      //     name: fullNameController.text.toString()));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              onPressed: navigateToStudentResultListPage, //navigate back to student list when icon is pressed
                              icon: const Icon(Icons.close, size: 34),
                            )
                          ),
                        const SizedBox(width: 35),
                        const Expanded(
                          child: Text(
                            "Add Student Result",
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    //Add image here using image.picker
                    //_buildImageContainer(),
                    TextFormField(
                      controller: subjectController,
                      decoration: const InputDecoration(labelText: "Subject"), //form validation
                      validator: (subject) => subject == null || subject.isEmpty
                          ? 'Please enter Subject'
                          : null,
                      onSaved: (subject) {
                        subjectController.text =
                            subjectController.text.toString();
                      },
                    ),

                    TextFormField(
                      controller: gradeController,
                      decoration: const InputDecoration(labelText: "Grade"),
                      validator: (grade) => grade == null || grade.isEmpty
                          ? 'Please enter grade'
                          : null,
                      onSaved: (grade) {
                        gradeController.text = gradeController.text.toString();
                      },
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0), 
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, 
                          vertical: 16.0),
                          minimumSize: const Size(200.0, 40.0),
                          ),
                        onPressed: () {
                          _saveStudentResult(); //when pressed, it triggers the savestudent
                        },
                        child: const Text("Submit Result"))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}   
