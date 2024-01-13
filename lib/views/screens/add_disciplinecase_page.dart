import 'package:flutter/material.dart';

class AddDisciplineCasePage extends StatefulWidget {
  final Function(String, String) onAddCase;
  const AddDisciplineCasePage({super.key, required this.onAddCase});

  @override
  State<AddDisciplineCasePage> createState() => _AddDisciplineCasePageState();
}

class _AddDisciplineCasePageState extends State<AddDisciplineCasePage> {
final _formKey = GlobalKey<FormState>();
final discptitleController = TextEditingController();
final discdescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[800],
        title: const Text('Add Discipline Case'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: discptitleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: discdescriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onAddCase(discptitleController.text, discdescriptionController.text);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
                  ),
                ),
              child: Text('Add Case'),
            ),
          ],
        ),
      ),
    );
  }
}