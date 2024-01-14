/*=====================================================
* Program: student_list_page.dart
* Purpose: display list of students, provide functionalities to view student details, add new students
* Notes: integrated with firebase to fetch & manipulate student data
*======================================================
*/
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../views/screens/student_profile_page.dart';
import 'dart:convert';
import '../views/screens/add_student_page.dart';
import 'package:school_management_app/models/student.dart';

class StudentsList extends StatefulWidget {
  const StudentsList({super.key});

  @override
  State<StudentsList> createState() => _StudentsListState();
}

class _StudentsListState extends State<StudentsList> {
  List<Student> _studentList = [];
  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  void _loadStudents() async { //load students from firebase
    final url = Uri.https(
      'flutter-school-managemen-d72cf-default-rtdb.asia-southeast1.firebasedatabase.app',
      'students-list.json');

    try {
      final response = await http.get(url); //HTTP GET request, to retrive data

      if(response.statusCode >= 400) {
        setState(() {
          _error = 'Error: Failed to retrieve data. Please try again later';
        });
      }
      print('#debug students_list_page.dart');
      print(response.body);

      //check if no record in firebase, terminate program
      if(response.body == null) {
        //disable loading
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final Map<String, dynamic> listData = json.decode(response.body);
      print(listData);
      final List<Student> loadedItems = [];
      // for (final items in listData.entries) {
      //   final 
      // }
      listData.forEach((key, value) {
        loadedItems.add(
        Student(
          id: key, 
          icNo: value['icno'], 
          name: value['name'], 
          className: value['classname'],
          ),
        );
      });
      //update state with loaded items
      setState(() {
        _studentList = loadedItems;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _error = 'Error occured..! Please try again later';
      });
    }
  }

  //function to add more students
  void _addStudent() async { //navigate to add student page
    final newStudent = await Navigator.of(context).push<Student>( //await for response to get newly added data
      MaterialPageRoute(
        builder: (ctx) => const AddStudentPage()
      ),
    );

    if (newStudent == null) {
      return;
    }
    
    setState(() {
      _studentList.add(newStudent); // update state when new student is added
    });
  }

  //function to remove student from the list and in firebase
  void _removeStudent (Student student) async {
    final index = _studentList.indexOf(student);
    setState(() {
      _studentList.remove(student);
    });

    final url = Uri.https(
        'flutter-school-managemen-d72cf-default-rtdb.asia-southeast1.firebasedatabase.app',
        'students-list/${student.id}.json');
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      setState(() {
        _studentList.insert(index, student);
      });
    }
  }

    void navigateToDashboardPage() {
      Navigator.pushReplacementNamed(context, '/dashboard'); //navigate to dashboard
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), 
          onPressed: navigateToDashboardPage),
        backgroundColor: Colors.deepPurple[800],
        title: const Text('Student List',
        style: TextStyle(
          fontSize: 22,
          fontStyle: FontStyle.italic
        ),),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : ListView.builder( //display student list
                  itemCount: _studentList.length,
                  itemBuilder: (ctx, index) {
                    final student = _studentList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),

                      //a student is represented in a card
                      child: Card(
                        child: ListTile(
                          title: Text(student.name,
                          style: const TextStyle(
                            fontSize: 22
                          ),),
                          subtitle: Text(student.className,
                          style: const TextStyle(
                            fontSize: 20
                          ),),
                          onTap: () { //student card is tapped
                            // Navigate to student profile page
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => StudentProfilePage( //students details
                                  student: student,
                                  onRemoveStudent: _removeStudent,
                                  ),
                              ),
                            );
                          },
                          
                        ),
                      ),
                    );
                  },
                ),

                floatingActionButton: FloatingActionButton( 
                  onPressed: _addStudent, //to add new students
                  backgroundColor: Colors.deepPurple[800],
                  child: const Icon(Icons.add),
                ),
              );
            }
          }