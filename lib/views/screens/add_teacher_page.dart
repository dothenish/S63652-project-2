import 'package:flutter/material.dart';
import 'package:school_management_app/models/teacher.dart';

class AddTeacherPage extends StatefulWidget {
  const AddTeacherPage({super.key});

  @override
  State<AddTeacherPage> createState() => _AddTeacherPageState();
}

class _AddTeacherPageState extends State<AddTeacherPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController icNoController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController subjectsController = TextEditingController();
  final TextEditingController hiredDateController = TextEditingController();
  String _imageUrl = "";
  
  void navigateToDashboard() {
    Navigator.pushReplacementNamed(context, '/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            height: 450,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white
              ),
            child: Form(
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
                          icon: Icon(Icons.close,
                        size: 34),) 
                        
                      ),
                      SizedBox(width: 35),
                      Expanded(
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
                  TextFormField(
                    controller: icNoController,
                    decoration: InputDecoration(labelText: "Identification Number"),
                  ),

                  TextFormField(
                    controller: fullNameController,
                    decoration: InputDecoration(labelText: "Full Name"),
                  ),
                  
                  TextFormField(
                    controller: subjectsController,
                    decoration: InputDecoration(labelText: "Subjects"),
                  ),
                  
                  TextFormField(
                    controller: hiredDateController,
                    decoration: InputDecoration(labelText: "Date Hired"),
                  ),
                  SizedBox(height: 16.0),
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
                      // Add your logic to save the class information
                      // For example, you can access the values using:
                      // selectedGrade, classNameController.text,
                      // homeroomTeacherNameController.text,
                      // homeroomTeacherIdController.text
                    },
                    child: Text('Add Teacher'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}