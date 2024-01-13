import 'dart:io';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:school_management_app/models/teacher.dart';

class AddTeacherPage extends StatefulWidget {
  const AddTeacherPage({super.key});

  @override
  State<AddTeacherPage> createState() => _AddTeacherPageState();
}

class _AddTeacherPageState extends State<AddTeacherPage> {
  final _formKey = GlobalKey<FormState>();
  final icNoController = TextEditingController();
  final fullNameController = TextEditingController();
  final subjectsController = TextEditingController();
  final hiredDateController = TextEditingController();
  //String _profileImageUrl = "";
  //late DateTime _selectedDate = DateTime.now();
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

    void _saveTeacher() async {
      if (_formKey.currentState!.validate()) {
        setState(() {
          _isSending = true;
        });
        _formKey.currentState!.save();
        final url = Uri.https(
          'flutter-school-managemen-d72cf-default-rtdb.asia-southeast1.firebasedatabase.app',
          'teachers-list.json'
        );
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(
            {
              'icno': icNoController.text,
              'name': fullNameController.text,
              'subject': subjectsController.text
            }
          )
        );

        print(response.body);
        print(response.statusCode);

        final Map<String, dynamic> resData = json.decode(response.body);

        //check the context for widget NULL
        if (!context.mounted) {
          return;
        }
        Navigator.of(context).pop(
          Teacher(
            id: resData['name'],
            icNo: icNoController.text.toString(), 
            name: fullNameController.text.toString(), 
            subject: subjectsController.text.toString())
        );
      }
    }

  //   void _presentDatePicker() {
  //   showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2021),
  //     lastDate: DateTime.now(),
  //   ).then((pickedDate) {
  //     //To check if the user cancel the date picker
  //     if (pickedDate == null) {
  //       return;
  //     }
  //     setState(() {
  //       _selectedDate = pickedDate;
  //     });
  //   });
  // }

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
                            icon: const Icon(Icons.close,
                          size: 34),) 
                          
                        ),
                        const SizedBox(width: 35),
                        const Expanded(
                            child: Text(
                              "Add Teacher",
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
                      ? 'Please enter teacher\'s identification number'
                      : null,
                      onSaved: (icno) {
                        icNoController.text = icNoController.text.toString();
                      },
                    ),
      
                    TextFormField(
                      controller: fullNameController,
                      decoration: const InputDecoration(labelText: "Full Name"),
                      validator: (fullname) => fullname == null || fullname.isEmpty
                      ? 'Please enter teacher\'s full name'
                      : null,
                      onSaved: (fullname) {
                        fullNameController.text = fullNameController.text.toString();
                      },
                    ),
                    
                    TextFormField(
                      controller: subjectsController,
                      decoration: const InputDecoration(labelText: "Subjects"),
                     validator: (subject) => subject == null || subject.isEmpty
                      ? 'Please choose teacher\'s subjects'
                      : null,
                      onSaved: (subjects) {
                        subjectsController.text = subjectsController.text.toString();
                      },
                    ),
                    
                    // TextFormField(
                    //   controller: hiredDateController,
                    //   decoration: InputDecoration(labelText: "Date Hired"),
                    //   validator: (datehired) => datehired == null || datehired.isEmpty
                    //   ? 'Please choose hired date'
                    //   : null,
                    // ),
                    // Container(
                    //   height: 70,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Expanded(
                    //         child: Text(
                    //           _selectedDate == null
                    //               ? 'No Date Chosen!'
                    //               : 'Hiring Date: ${DateFormat.yMd().format(_selectedDate)}',
                    //         ),
                    //       ),
                    //       TextButton(
                    //         onPressed: () {
                    //           _presentDatePicker();
                    //         },
                    //         child: const Text(
                    //           'Choose Date',
                    //           style: TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
                      ? null : _saveTeacher,
                      child: _isSending
                      ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(),
                      )
                      : const Text('Add Teacher'),
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

   // Container to display selected image from the gallery
  //  Widget _buildImageContainer() {
  //   return Stack(
  //     alignment: Alignment.bottomRight,
  //     children: [
  //       Container(
  //         margin: const EdgeInsets.symmetric(vertical: 16.0),
  //         height: 140,
  //         width: 140,
  //         decoration: BoxDecoration(
  //           shape: BoxShape.circle,
  //           border: Border.all(
  //             width: 4,
  //             color: Colors.grey,
  //           ),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.black.withOpacity(0.1),
  //             ),
  //           ],
  //         ),
  //         child: ClipOval(
  //           child: _profileImageUrl.isNotEmpty
  //               ? Image.file(
  //                   File(_profileImageUrl),
  //                   fit: BoxFit.cover,
  //                 )
  //               : const Column(
  //                   // Placeholder when no image is chosen
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Icon(
  //                       Icons.person,
  //                       size: 80,
  //                       color: Colors.grey,
  //                     ),
  //                   ],
  //                 ),
  //         ),
  //       ),
  //       IconButton(
  //         onPressed: _pickImage,
  //         icon: const Icon(Icons.add_a_photo),
  //       ),
  //     ],
  //   );
  // }
}