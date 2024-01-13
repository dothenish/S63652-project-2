import 'package:flutter/material.dart';

class AddStudentResultPage extends StatefulWidget {
  const AddStudentResultPage({super.key});

  @override
  State<AddStudentResultPage> createState() => _AddStudentResultPageState();
}

class _AddStudentResultPageState extends State<AddStudentResultPage> {
  final _formKey = GlobalKey<FormState>();
  final subjectController = TextEditingController();
  final gradeController = TextEditingController();

    void navigateToStudentResultListPage() {
      Navigator.pushReplacementNamed(context, '/students_result_list_page');
    }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white
                ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: navigateToStudentResultListPage, 
                            icon: const Icon(Icons.close,
                          size: 34),) 
                          
                        ),
                        const SizedBox(width: 35),
                        const Expanded(
                            child: Text(
                              "Add Student Result",
                              style: TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    //Add image here using image.picker
                    //_buildImageContainer(),
                    TextFormField(
                      controller: subjectController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Subject"),
                      validator: (subject) => subject == null || subject.isEmpty
                      ? 'Please enter Subject'
                      : null,
                      onSaved: (subject) {
                        subjectController.text = subjectController.text.toString();
                      },
                    ),
      
                    TextFormField(
                      controller: gradeController,
                      decoration: const InputDecoration(labelText: "Grade"),
                      validator: (grade) => grade == null || grade.isEmpty
                      ? 'Please enter grade'
                      : null,
                      onSaved: (grade) {
                        gradeController.text = gradeController.text.toString();
                      },
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {}, 
                      child: Text("Submit Result"))
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //   backgroundColor: Colors.deepPurple[800],
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(30.0), 
                    //     ),
                    //     padding: const EdgeInsets.symmetric(
                    //       horizontal: 20.0, 
                    //       vertical: 16.0),
                    //       minimumSize: const Size(200.0, 40.0),
                    //       ),
                    //   onPressed: _isSending
                    //   ? null : _saveStudent,
                    //   child: _isSending
                    //   ? const SizedBox(
                    //     height: 16,
                    //     width: 16,
                    //     child: CircularProgressIndicator(),
                    //   )
                    //   : const Text('Add Student'),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}    
