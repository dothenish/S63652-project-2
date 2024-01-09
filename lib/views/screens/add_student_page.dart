import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({super.key});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}



class _AddStudentPageState extends State<AddStudentPage> {

  final TextEditingController gradeController = TextEditingController();
  final TextEditingController classNameController = TextEditingController();
  final TextEditingController homeroomTeacherNameController = TextEditingController();
  final TextEditingController homeroomTeacherIdController = TextEditingController();
  String _imageUrl = "";

      void navigateToDashboard() {
      Navigator.pushReplacementNamed(context, '/dashboard');
      }

      Future<void> _pickImage() async {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _imageUrl = pickedFile.path;
        }
      });
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
                  TextFormField(
                    controller: gradeController,
                    decoration: InputDecoration(labelText: "Grade"),
                  ),

                  TextFormField(
                    controller: classNameController,
                    decoration: InputDecoration(labelText: "Full Name"),
                  ),
                  
                  TextFormField(
                    controller: homeroomTeacherNameController,
                    decoration: InputDecoration(labelText: "Student ID"),
                  ),
                  
                  TextFormField(
                    controller: homeroomTeacherIdController,
                    decoration: InputDecoration(labelText: "Class"),
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
                    child: Text('Add Student'),
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