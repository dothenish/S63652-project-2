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

  void _loadStudents() async {
    final url = Uri.https(
      'flutter-school-managemen-d72cf-default-rtdb.asia-southeast1.firebasedatabase.app',
      'students-list.json');

    try {
      final response = await http.get(url);

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
  void _addStudent() async {
    final newStudent = await Navigator.of(context).push<Student>(
      MaterialPageRoute(
        builder: (ctx) => const AddStudentPage()
      ),
    );

    if (newStudent == null) {
      return;
    }
    
    setState(() {
      _studentList.add(newStudent);
    });
  }

  //func to delete item
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
      Navigator.pushReplacementNamed(context, '/dashboard');
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
              : ListView.builder(
                  itemCount: _studentList.length,
                  itemBuilder: (ctx, index) {
                    final student = _studentList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
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
                          onTap: () {
                            // Navigate to student profile page
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => StudentProfilePage(
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
        onPressed: _addStudent,
        backgroundColor: Colors.deepPurple[800],
        child: const Icon(Icons.add),
      ),
    );
  }
}