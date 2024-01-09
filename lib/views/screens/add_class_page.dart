import 'package:flutter/material.dart';

class AddClassPage extends StatefulWidget {
  @override
  _AddClassPageState createState() => _AddClassPageState();
}

class _AddClassPageState extends State<AddClassPage> {
  //String selectedGrade = ''; // To store the selected grade
  final TextEditingController gradeController = TextEditingController();
  final TextEditingController classNameController = TextEditingController();
  final TextEditingController homeroomTeacherNameController = TextEditingController();
  final TextEditingController homeroomTeacherIdController = TextEditingController();

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
                  Text("Add Class",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold
                  ),),
                  TextFormField(
                    controller: gradeController,
                    decoration: InputDecoration(labelText: "Grade"),
                  ),

                  TextFormField(
                    controller: classNameController,
                    decoration: InputDecoration(labelText: "Class Name"),
                  ),
                  
                  TextFormField(
                    controller: homeroomTeacherNameController,
                    decoration: InputDecoration(labelText: "Homeroom Teacher's Name"),
                  ),
                  
                  TextFormField(
                    controller: homeroomTeacherIdController,
                    decoration: InputDecoration(labelText: "Homeroom Teacher's ID"),
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
                    child: Text('Add Class'),
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
