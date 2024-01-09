/*=====================================================
* Program: discipline_case.dart
* Purpose: discipline case object with its attributes
* Notes:
*======================================================
*/

class DisciplineCase {
  String id;
  String studentId;
  DateTime date;
  String description;

  DisciplineCase({
    required this.id,
    required this.studentId,
    required this.date,
    required this.description,
  });
}