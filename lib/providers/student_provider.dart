import 'package:flutter/material.dart';

class StudentProvider extends ChangeNotifier {
  String? studentId;

  void setStudentId(String id) {
    studentId = id;
    notifyListeners();
  }

  String? get getStudentId => studentId;
}