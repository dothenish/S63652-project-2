/*=====================================================
* Program: teacher_list_page.dart
* Purpose: display list of teachers added
* Notes: 
*======================================================
*/
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../views/screens/add_teacher_page.dart';
import '../views/screens/teacher_profile_page.dart';
import 'package:school_management_app/models/teacher.dart';

class TeachersList extends StatefulWidget {
  const TeachersList({super.key});

  @override
  State<TeachersList> createState() => _TeachersListState();
}

class _TeachersListState extends State<TeachersList> {
  List<Teacher> _teacherList = [];
  var _isLoading = true;
  String? _error;

  @override
  void initState() { //initialized state when widget is created
    super.initState();
    _loadTeachers();
  }

    void _loadTeachers() async {
    final url = Uri.https(
      'flutter-school-managemen-d72cf-default-rtdb.asia-southeast1.firebasedatabase.app',
      'teachers-list.json');
      
      try {
      final response = await http.get(url); //HTTP GET method to fetch list from firebase

      if(response.statusCode >= 400) {
        setState(() {
          _error = 'Error: Failed to retrieve data. Please try again later';
        });
      }
      print('#debug teachers_list_page.dart');
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
      final List<Teacher> loadedItems = [];
      // for (final items in listData.entries) {
      //   final 
      // }
      listData.forEach((key, value) {
        loadedItems.add(
        Teacher(
          id: key, 
          icNo: value['icno'], 
          name: value['name'], 
          subject: value['subject'],
          ),
        );
      });
      //update state with loaded items
      setState(() {
        _teacherList = loadedItems;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _error = 'Error occured..! Please try again later';
      });
    }
  }

    void _addTeacher() async { //navigation to add teacher page
    final newTeacher = await Navigator.of(context).push<Teacher>(
      MaterialPageRoute(
        builder: (ctx) => const AddTeacherPage()
      ),
    );

        if (newTeacher == null) {
      return;
    }
    setState(() {
      _teacherList.add(newTeacher);
    });
  }

    //func to delete teacher from list and database
    void _removeTeacher (Teacher teacher) async {
      final index = _teacherList.indexOf(teacher);
      setState(() {
        _teacherList.remove(teacher);
      });

      final url = Uri.https(
          'flutter-school-managemen-d72cf-default-rtdb.asia-southeast1.firebasedatabase.app',
          'teachers-list/${teacher.id}.json');
      final response = await http.delete(url); //HTTP DELETE method

      if (response.statusCode >= 400) {
        setState(() {
          _teacherList.insert(index, teacher);
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
          onPressed: navigateToDashboardPage, 
          icon: const Icon(Icons.arrow_back)),
          backgroundColor: Colors.deepPurple[800],
        title: const Text('Teacher List',
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
        itemCount: _teacherList.length,
        itemBuilder: (ctx, index) {
          final teacher = _teacherList[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),

            //each teacher is represented by a card
            child: Card(
              child: ListTile(
                title: Text(teacher.name,
                style: const TextStyle(
                  fontSize: 26
                  ),
                ),
                subtitle: Text(teacher.icNo,
                style: const TextStyle(
                  fontSize: 26
                  ),
                ),
                onTap: () {
                // Navigate to teacher profile page
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => TeacherProfilePage(
                      teacher: teacher,
                      onRemoveTeacher: _removeTeacher,),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addTeacher,
          backgroundColor: Colors.deepPurple[800],
          child: const Icon(Icons.add)
          ),
        );
      }
    }
