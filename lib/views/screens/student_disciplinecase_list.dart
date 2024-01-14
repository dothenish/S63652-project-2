/*=====================================================
* Program: student_disciplinecase_list.dart
* Purpose: display list of result for a specific student
* Notes: fetch result form firebase
*======================================================
*/
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:school_management_app/models/discipline_case.dart';
import 'package:school_management_app/providers/student_provider.dart';

class StudentDisciplineCasePage extends StatefulWidget {
  const StudentDisciplineCasePage({super.key});

  @override
  State<StudentDisciplineCasePage> createState() =>
      _StudentDisciplineCasePageState();
}

class _StudentDisciplineCasePageState extends State<StudentDisciplineCasePage> {
  var _isLoading = true;
  String? _error;
  List<DisciplineCase> disciplineCase = [];

  void navigateToAddStudentDisciplineCasePage() {
    Navigator.pushReplacementNamed(context, '/add_student_case_page');
  }

  Future<List<DisciplineCase>> _loadDiscipline() async {
    final url = Uri.https(
        'flutter-school-managemen-d72cf-default-rtdb.asia-southeast1.firebasedatabase.app',
        'students-list/${Provider.of<StudentProvider>(context, listen: false).getStudentId}/discipline-case.json');

    try {
      final response = await http.get(url);

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
        // return [];
      }

      // Parse the JSON data
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      print(jsonData);

      // Loop through the map and create a Result object for each entry
      jsonData.forEach((id, data) {
        disciplineCase.add(DisciplineCase(
          id: id,
          caseTitle: data['case-title'],
          caseDescription: data['case-description'],
        ));
      });

      return disciplineCase;
    } catch (error) {
      setState(() {
        _error = 'Error occured..! Please try again later';
      });
    }
    return [];
  }

    // Function to delete a result
    Future<void> _deleteCase(String caseId) async {
    final url = Uri.https(
      'flutter-school-managemen-d72cf-default-rtdb.asia-southeast1.firebasedatabase.app',
      'students-list/${Provider.of<StudentProvider>(context, listen: false).getStudentId}/discipline-case/$caseId.json',
    );

      final response = await http.delete(url); //HTTP DELETE method to delete student case

      if (response.statusCode == 200) {
        setState(() {
          disciplineCase.removeWhere((disccase) => disccase.id == caseId);
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[800],
          title: const Text('Student Discipline Case'),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future:
              _loadDiscipline(), // fetchResults() is the function that returns Future<List<Result>>
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              print(snapshot.data);
              // List<Result> results = snapshot.data;
              return ListView.builder(
                itemCount: disciplineCase.length,
                itemBuilder: (context, index) {
                return Dismissible( //swipe right to delete
                key: Key(disciplineCase[index].id),
                onDismissed: (direction) async {
                  await _deleteCase(disciplineCase[index].id);
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
                  title: Text(disciplineCase[index].caseTitle),
                  subtitle: Text(disciplineCase[index].caseDescription),
                   ),
                 );
                },
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: navigateToAddStudentDisciplineCasePage,
          backgroundColor: Colors.deepPurple[800],
          child: const Icon(Icons.add),
        ));
  }
}