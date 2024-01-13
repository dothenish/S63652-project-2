import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:school_management_app/views/screens/add_student_page.dart';
//import 'add_class_page.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
    void navigateToAddStudentPage() {
      Navigator.pushReplacementNamed(context, '/add_student_page');
      }

    void navigateToAddTeacherPage() {
      Navigator.pushReplacementNamed(context, '/add_teacher_page');
      }

    void navigateToLoginPage() {
      Navigator.pushReplacementNamed(context, '/loginpage');
      }
    
    void navigateToTeachersListPage() {
      Navigator.pushReplacementNamed(context, '/teachers_list_page');
      }
    
    void navigateToStudentsListPage() {
      Navigator.pushReplacementNamed(context, '/students_list_page');
      }

      

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.deepPurple[800]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40.0),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Welcome back,",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontStyle: FontStyle.italic
                      )),
                      IconButton(
                        onPressed: () => FirebaseAuth.instance.signOut(), 
                        icon: const Icon(Icons.logout),
                        color: Colors.white,)
                    ],
                  ),
                  const Text("Admin",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40
                  ),),
                  const Text("To\nSchool Management App",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.white
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20.0),
            Expanded(
              child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35.0),
                      topRight: Radius.circular(35.0)
                    ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.purple[50]
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Students",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold
                                )),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurple[800],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0), 
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, 
                                          vertical: 16.0),
                                          //minimumSize: const Size(200.0, 40.0),
                                          ),
                                      onPressed: navigateToStudentsListPage, 
                                      child: const Text("View Students")
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurple[800],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0), 
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, 
                                          vertical: 16.0),
                                          //minimumSize: const Size(200.0, 40.0),
                                          ),
                                      onPressed: navigateToAddStudentPage, 
                                      child: const Text("Add Student"))
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Container(
                            padding: const EdgeInsets.all(20),
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.purple[50]
                            ) ,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Teachers",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold
                                )),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurple[800],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0), 
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, 
                                          vertical: 16.0),
                                          //minimumSize: const Size(200.0, 40.0),
                                          ),
                                      onPressed: navigateToTeachersListPage, 
                                      child: const Text("View Teacher")
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurple[800],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0), 
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, 
                                          vertical: 16.0),
                                          //minimumSize: const Size(200.0, 40.0),
                                          ),
                                      onPressed: navigateToAddTeacherPage, 
                                      child: const Text("Add Teacher"))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

                