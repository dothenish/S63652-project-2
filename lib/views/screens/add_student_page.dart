/*=====================================================
* Program: add_student_page.dart
* Purpose: Adding new student to firebase
* Notes: validates student icno, name, class name
*======================================================
*/
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:school_management_app/models/student.dart';


class AddStudentPage extends StatefulWidget {
  const AddStudentPage({super.key});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

//final databaseReference = FirebaseDatabase.instance.ref("students");

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>(); //for validation
  final icNoController = TextEditingController();
  final fullNameController = TextEditingController();
  //final gradeController = TextEditingController();
  final classNameController = TextEditingController();
  //String _profileImageUrl = "";
  var _isSending = false;

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

      void _saveStudent() async{ //save input data
        if (_formKey.currentState!.validate()) {
          setState(() {
            _isSending = true;
          });
          _formKey.currentState!.save();
          final url = Uri.https(
            'flutter-school-managemen-d72cf-default-rtdb.asia-southeast1.firebasedatabase.app',
            'students-list.json'
          );
          final response = await http.post( //HTTP POST request to firebase to add a new student
            url,
            headers: {
              'Content-Type': 'application/json',
            },
            body: json.encode(
              {
                'icno': icNoController.text,
                'name': fullNameController.text,
                'classname': classNameController.text,
              }
            ),
          );

      print(response.body);
      print(response.statusCode);

      final Map<String, dynamic> resData = json.decode(response.body);

      //Check the context for widget NULL
      if (!context.mounted) {
        return;
      }
      Navigator.of(context).pop(
        Student(
        id: resData['name'],
        icNo: icNoController.text.toString(), 
        className: classNameController.text.toString(), 
        name: fullNameController.text.toString())
      );
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
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white
                ),
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
                            icon: const Icon(Icons.close, //when user click on the 'X' button
                          size: 34),) 
                          
                        ),
                        const SizedBox(width: 35),
                        const Expanded(
                            child: Text(
                              "Add Student",
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
                      decoration: const InputDecoration(labelText: "Identification Number"),
                      validator: (icno) => icno == null || icno.isEmpty
                      ? 'Please enter student\'s identification number'
                      : null,
                      onSaved: (icno) {
                        icNoController.text = icNoController.text.toString();
                      },
                    ),
      
                    TextFormField(
                      controller: fullNameController,
                      decoration: const InputDecoration(labelText: "Full Name"),
                      validator: (fullname) => fullname == null || fullname.isEmpty
                      ? 'Please enter student\'s full name number'
                      : null,
                      onSaved: (fullname) {
                        fullNameController.text = fullNameController.text.toString();
                      },
                    ),
                    
                    // TextFormField(
                    //   controller: gradeController,
                    //   decoration: const InputDecoration(labelText: "Grade"),
                    //   validator: (grade) => grade == null || grade.isEmpty
                    //   ? 'Please choose student\'s grade'
                    //   : null,
                    // ),
                    
                    TextFormField(
                      controller: classNameController,
                      decoration: const InputDecoration(labelText: "Class"),
                      validator: (className) => className == null || className.isEmpty
                      ? 'Please enter student\'s class name'
                      : null,
                      onSaved: (className) {
                        classNameController.text = classNameController.text.toString();
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
                      onPressed: _isSending
                      ? null : _saveStudent,
                      child: _isSending
                      ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(),
                      )
                      : const Text('Add Student'),
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