import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:school_management_app/models/result.dart';

class AddStudResultPage extends StatefulWidget {
  AddStudResultPage({super.key, required this.onAddResult});
  final Function(String, String) onAddResult;

  @override
  State<AddStudResultPage> createState() => _AddStudResultPageState();
}

class _AddStudResultPageState extends State<AddStudResultPage> {
  final _formKey = GlobalKey<FormState>();
  final subjectController = TextEditingController();
  final gradeController = TextEditingController();

  // var _isSending = false;

  // void _saveResult() async {
  //   if (_formKey.currentState!.validate()) {
  //         setState(() {
  //           _isSending = true;
  //         });
  //         _formKey.currentState!.save();
  //         final url = Uri.https(
  //           'flutter-school-managemen-d72cf-default-rtdb.asia-southeast1.firebasedatabase.app',
  //           'students-list/idstudent/result.json'
  //         );
  //         final response = await http.post(
  //           url,
  //           headers: {
  //             'Content-Type': 'application/json',
  //           },
  //           body: json.encode(
  //             {
  //               'studentid': icNoController.text,
  //               //'name': fullNameController.text,
  //               //'classname': classNameController.text,
  //             }
  //           ),
  //         );

  //     print(response.body);
  //     print(response.statusCode);

  //     final Map<String, dynamic> resData = json.decode(response.body);

  //     //Check the context for widget NULL
  //     if (!context.mounted) {
  //       return;
  //     }
  //     Navigator.of(context).pop(
  //       Student(
  //       id: resData['name'],
  //       icNo: icNoController.text.toString(), 
  //       className: classNameController.text.toString(), 
  //       name: fullNameController.text.toString())
  //     );
  //   }
  // }
  
  
  
  
  
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[800],
        title: Text('Add Result'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: subjectController,
              decoration: InputDecoration(labelText: 'Subject'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: gradeController,
              decoration: InputDecoration(labelText: 'Grade'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onAddResult(subjectController.text, gradeController.text);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
                  ),
                ),
              child: Text('Add Result'),
            ),
          ],
        ),
      ),
    );
  }
}