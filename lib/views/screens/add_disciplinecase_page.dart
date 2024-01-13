import 'package:flutter/material.dart';

class AddDisciplineCasePage extends StatefulWidget {
  const AddDisciplineCasePage({super.key});

  @override
  State<AddDisciplineCasePage> createState() => _AddDisciplineCasePageState();
}

class _AddDisciplineCasePageState extends State<AddDisciplineCasePage> {
  final _formKey = GlobalKey<FormState>();
  final disciplineCaseTitleController = TextEditingController();
  final disciplineCaseDescriptionController = TextEditingController();

      void navigateToStudentDisciplineCaseListPage() {
      Navigator.pushReplacementNamed(context, '/students_disciplinecase_list_page');
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
                            onPressed: navigateToStudentDisciplineCaseListPage, 
                            icon: const Icon(Icons.close,
                          size: 34),) 
                          
                        ),
                        const SizedBox(width: 35),
                        const Expanded(
                            child: Text(
                              "Add Discipline Case",
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
                      controller: disciplineCaseTitleController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Discipline Case Title"),
                      validator: (title) => title == null || title.isEmpty
                      ? 'Please enter title'
                      : null,
                      onSaved: (title) {
                        disciplineCaseTitleController.text = disciplineCaseTitleController.text.toString();
                      },
                    ),
      
                    TextFormField(
                      controller: disciplineCaseDescriptionController,
                      decoration: const InputDecoration(labelText: "Description"),
                      validator: (description) => description == null || description.isEmpty
                      ? 'Please enter description'
                      : null,
                      onSaved: (fullname) {
                        disciplineCaseDescriptionController.text = disciplineCaseDescriptionController.text.toString();
                      },
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {}, 
                      child: Text("Submit Case"))
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
