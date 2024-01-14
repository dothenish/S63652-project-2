/*=====================================================
* Program: add_disciplinecase_page.dart
* Purpose: add discipline case for a specific student
* Notes: 
*======================================================
*/
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:school_management_app/providers/student_provider.dart';

class AddDisciplineCasePage extends StatefulWidget {
  const AddDisciplineCasePage({super.key});

  @override
  State<AddDisciplineCasePage> createState() => _AddDisciplineCasePageState();
}

class _AddDisciplineCasePageState extends State<AddDisciplineCasePage> {
  final _formKey = GlobalKey<FormState>();
  final disciplineCaseTitleController = TextEditingController();
  final disciplineCaseDescriptionController = TextEditingController();
  var _isSending = true;
  String? _error;

  void navigateToStudentDisciplineCaseListPage() {
    Navigator.pushReplacementNamed(
        context, '/students_disciplinecase_list_page');
  }

  void _saveDiscipline() async { //validate form input
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSending = true;
      });
      _formKey.currentState!.save();
      final url = Uri.https(
          'flutter-school-managemen-d72cf-default-rtdb.asia-southeast1.firebasedatabase.app',
          'students-list/${Provider.of<StudentProvider>(context, listen: false).getStudentId}/discipline-case.json');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'case-title': disciplineCaseTitleController.text,
          'case-description': disciplineCaseDescriptionController.text,
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

  @override
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
                              onPressed:
                                  navigateToStudentDisciplineCaseListPage, //navigate back to discipline case list when icon is pressed
                              icon: const Icon(Icons.close, size: 34),
                            )),
                        const SizedBox(width: 35),
                        const Expanded(
                          child: Text(
                            "Add Discipline Case",
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
                      controller: disciplineCaseTitleController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: "Discipline Case Title"),
                      validator: (title) => title == null || title.isEmpty
                          ? 'Please enter title'
                          : null,
                      onSaved: (title) {
                        disciplineCaseTitleController.text =
                            disciplineCaseTitleController.text.toString();
                      },
                    ),

                    TextFormField(
                      controller: disciplineCaseDescriptionController,
                      decoration:
                          const InputDecoration(labelText: "Description"),
                      validator: (description) =>
                          description == null || description.isEmpty
                              ? 'Please enter description'
                              : null,
                      onSaved: (fullname) {
                        disciplineCaseDescriptionController.text =
                            disciplineCaseDescriptionController.text.toString();
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
                          _saveDiscipline();
                        },
                        child: const Text("Submit Case"))
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
