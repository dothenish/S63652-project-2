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
            const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: IconButton(
                  //   icon: Icon(Icons.logout,
                  //   size: 20,
                  //   color: Colors.white), onPressed: () {  },
                  // ),
                  // ),
                  //SizedBox(height: 20,),
                  Text("Welcome back,",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontStyle: FontStyle.italic
                  ),),
                  Text("Name",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40
                  ),),
                ],
              ),
            ),
            const SizedBox(height: 20.0,),
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
                          padding: EdgeInsets.all(20),
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
                                      child: Text("View Students")
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
                                      child: const Text("Add Students"))
                                  ],
                                ),
                              ],
                            ),
                        ),
                        const SizedBox(height: 20,),
                                                Container(
                          padding: EdgeInsets.all(20),
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

      // appBar: AppBar(
      //   title: Text('Home Page'),
      // ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       ElevatedButton(
      //         onPressed: () {
      //           // Navigate to the page where admin can manage teachers
      //           Navigator.pushNamed(context, '/manage_teachers_page');
      //         },
      //         child: Text('Manage Teachers'),
      //       ),
      //       SizedBox(height: 20.0),
      //       ElevatedButton(
      //         onPressed: () {
      //           // Navigate to the page where admin can manage students
      //           Navigator.pushNamed(context, '/manage_students_page');
      //         },
      //         child: Text('Manage Students'),
      //       ),
      //     ],
      //   ),
      // ),


                // Positioned(
                //   bottom: 16,
                //   right: 16,
                //   child:FloatingActionButton(
                //     onPressed: navigateToAddClassPage,
                //     backgroundColor: Colors.deepPurple[800],
                //   child: Icon(Icons.add)))
                