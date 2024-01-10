/*=====================================================
* Program: student.dart
* Purpose: student object with its attributes
* Notes:
*======================================================
*/

class Student {
  String icNo;
  String name;
  String className;
  String gender;

  Student({
    required this.icNo, 
    required this.name, 
    required this.className,
    required this.gender
  });
}