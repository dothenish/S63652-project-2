/*=====================================================
* Program: student_result_list_page.dart
* Purpose: display list of result for a specific student
* Notes: fetch result form firebase
*======================================================
*/
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:school_management_app/models/result.dart';

import 'package:school_management_app/providers/student_provider.dart';

class StudentResultPage extends StatefulWidget {
  const StudentResultPage({super.key});

  @override
  State<StudentResultPage> createState() => _StudentResultPageState();
}

class _StudentResultPageState extends State<StudentResultPage> {
  var _isLoading = true;
  String? _error;
  List<Result> results = [];

  void navigateToAddStudentResultPage() { //navigate to the add result page
    Navigator.pushReplacementNamed(context, '/add_student_result_page');
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _loadResults();
  // }

  Future<List<Result>> _loadResults() async { //fetct student result
    final url = Uri.https(
        'flutter-school-managemen-d72cf-default-rtdb.asia-southeast1.firebasedatabase.app',
        'students-list/${Provider.of<StudentProvider>(context, listen: false).getStudentId}/result.json');

    try {
      final response = await http.get(url); //HTTP GET method to fetch added student result

      if (response.statusCode >= 400) {
        setState(() {
          _error = 'Error: Failed to retrieve data. Please try again later';
        });
      }
      print('#debug students_list_page.dart');
      print(response.body);

      //check if no record in firebase, terminate program
      if (response.body == null) {
        //disable loading
        setState(() {
          _isLoading = false;
        });
        return [];
      }

      // Parse the JSON data
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      print(jsonData);

      // Loop through the map and create a Result object for each entry
      jsonData.forEach((id, data) {
        results.add(Result(
          id: id,
          subjectName: data['subjectName'],
          grade: data['grade'],
        ));
      });

      return results;
    } catch (error) {
      setState(() {
        _error = 'Error occured..! Please try again later';
      });
    }
    return [];
  }

  // Function to delete a result
  Future<void> _deleteResult(String resultId) async {
    final url = Uri.https(
      'flutter-school-managemen-d72cf-default-rtdb.asia-southeast1.firebasedatabase.app',
      'students-list/${Provider.of<StudentProvider>(context, listen: false).getStudentId}/result/$resultId.json',
    );

      final response = await http.delete(url); //HTTP DELETE method to delete student result

      if (response.statusCode == 200) {
        setState(() {
          results.removeWhere((result) => result.id == resultId);
        });
      }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[800],
          title: const Text('Student Result'),
          centerTitle: true,
        ),
        body: FutureBuilder( //asynchronously load and display student result
          future:
              _loadResults(), // fetchResults() is the function that returns Future<List<Result>>
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              print(snapshot.data);

              // List<Result> results = snapshot.data;
          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              return Dismissible( //swipe right to delete
                key: Key(results[index].id),
                onDismissed: (direction) async {
                  await _deleteResult(results[index].id);
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                child: ListTile(
                  title: Text(results[index].subjectName),
                  subtitle: Text(results[index].grade),
                ),
              );
            },
          );
        }
      }),
  
      floatingActionButton: FloatingActionButton( //add othe result
          onPressed: navigateToAddStudentResultPage,
          backgroundColor: Colors.deepPurple[800],
          child: const Icon(Icons.add),
        ));
  }
}