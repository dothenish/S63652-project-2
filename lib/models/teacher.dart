/*=====================================================
* Program: teacher.dart
* Purpose: teacher object with its attributes
* Notes:
*======================================================
*/

class Teacher {
  String icNo;
  String name;
  String subject;
  String gender;
  String address;
  DateTime hiringDate; 

  Teacher({
    required this.icNo, 
    required this.name, 
    required this.subject,
    required this.gender,
    required this.address,
    required this.hiringDate
  });
}