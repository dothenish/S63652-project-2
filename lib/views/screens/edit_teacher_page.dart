//import 'dart:io';
import 'dart:convert';
//import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:school_management_app/models/teacher.dart';
import 'package:school_management_app/providers/student_provider.dart';

class EditTeacherPage extends StatefulWidget {
  const EditTeacherPage({super.key});

  @override
  State<EditTeacherPage> createState() => _EditTeacherPageState();
}

class _EditTeacherPageState extends State<EditTeacherPage> {

  final _formKey = GlobalKey<FormState>();
  final icNoController = TextEditingController();
  final fullNameController = TextEditingController();
  final subjectsController = TextEditingController();
  final hiredDateController = TextEditingController();
  //String _profileImageUrl = "";
  //late DateTime _selectedDate = DateTime.now();
  var _isSending = false;
  String? _error;
  var _isLoading = true;

  void navigateToDashboard() {
    Navigator.pushReplacementNamed(context, '/dashboard');
  }

  //   Future<void> _pickImage() async {
  //   final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     if (pickedFile != null) {
  //       _profileImageUrl = pickedFile.path;
  //     }
  //   });
  // }

  void _editTeacher() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSending = true;
      });
      _formKey.currentState!.save();
      final url = Uri.https(
          'flutter-school-managemen-d72cf-default-rtdb.asia-southeast1.firebasedatabase.app',
          'teachers-list/${Provider.of<StudentProvider>(context, listen: false).getStudentId}.json');
      final response = await http.put(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'icno': icNoController.text,
            'name': fullNameController.text,
            'subject': subjectsController.text
          }));
      setState(() {});

      print(response.body);
      print(response.statusCode);

      final Map<String, dynamic> resData = json.decode(response.body);

      //check the context for widget NULL
      if (!context.mounted) {
        return;
      }
      Navigator.of(context).pop(Teacher(
          id: resData['name'],
          icNo: icNoController.text.toString(),
          name: fullNameController.text.toString(),
          subject: subjectsController.text.toString()));
    }
  }

  Future<Teacher> getIndividualTeacher() async {
    final url = Uri.https(
        'flutter-school-managemen-d72cf-default-rtdb.asia-southeast1.firebasedatabase.app',
        'teachers-list/${Provider.of<StudentProvider>(context, listen: false).getStudentId}.json');

    try {
      final response = await http.get(url);

      if (response.statusCode >= 400) {
        setState(() {
          _error = 'Error: Failed to retrieve data. Please try again later';
        });
      }
      print('#debug teachers_list_page.dart');
      print(response.body);

      //check if no record in firebase, terminate program
      if (response.body == null) {
        //disable loading
        setState(() {
          _isLoading = false;
        });
        // return [];
        return Teacher(
          id: '',
          icNo: '',
          name: '',
          subject: '',
        );
      }

      // Parse the JSON data
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      print(jsonData);

      Teacher teacher = Teacher(
        id: Provider.of<StudentProvider>(context, listen: false)
            .getStudentId!, // use the student id as the teacher id
        icNo: jsonData['icno'],
        name: jsonData['name'],
        subject: jsonData['subject'],
      );

      icNoController.text = teacher.icNo;
      fullNameController.text = teacher.name;
      subjectsController.text = teacher.subject;

      // Loop through the map and create a Result object for each entry
      // jsonData.forEach((id, data) {
      //   teacher.add(Teacher(
      //     id: id,
      //     icNo: data['icno'],
      //     name: data['name'],
      //     subject: data['subject'],
      //   ));
      // });

      return teacher;
    } catch (error) {
      setState(() {
        _error = 'Error occured..! Please try again later';
      });
    }
    // return [];
    return Teacher(
      id: '',
      icNo: '',
      name: '',
      subject: '',
    );
  }

  @override
  void initState() {
    super.initState();
    // _loadTeachers();
    getIndividualTeacher();
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
                              onPressed: navigateToDashboard,
                              icon: const Icon(Icons.close, size: 34),
                            )),
                        const SizedBox(width: 35),
                        const Expanded(
                          child: Text(
                            "Edit Teacher Details",
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
                      controller: icNoController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: "Identification Number"),
                      validator: (icno) => icno == null || icno.isEmpty
                          ? 'Please enter teacher\'s identification number'
                          : null,
                      onSaved: (icno) {
                        icNoController.text = icNoController.text.toString();
                      },
                    ),

                    TextFormField(
                      controller: fullNameController,
                      decoration: const InputDecoration(labelText: "Full Name"),
                      validator: (fullname) =>
                          fullname == null || fullname.isEmpty
                              ? 'Please enter teacher\'s full name'
                              : null,
                      onSaved: (fullname) {
                        fullNameController.text =
                            fullNameController.text.toString();
                      },
                    ),

                    TextFormField(
                      controller: subjectsController,
                      decoration: const InputDecoration(labelText: "Subjects"),
                      validator: (subject) => subject == null || subject.isEmpty
                          ? 'Please choose teacher\'s subjects'
                          : null,
                      onSaved: (subjects) {
                        subjectsController.text =
                            subjectsController.text.toString();
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
                            horizontal: 20.0, vertical: 16.0),
                        minimumSize: const Size(200.0, 40.0),
                      ),
                      onPressed: _isSending ? null : _editTeacher,
                      child: _isSending
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(),
                            )
                          : const Text('Update Teacher'),
                    ),
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