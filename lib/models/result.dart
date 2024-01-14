/*=====================================================
* Program: result.dart
* Purpose: result object with its attributes
* Notes:
*======================================================
*/
import 'dart:convert';

class Result {
  final String id;
  final String subjectName;
  final String grade;

  Result({
    required this.id,
    required this.subjectName,
    required this.grade,
  });
}