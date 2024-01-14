/*=====================================================
* Program: student.dart
* Purpose: student object with its attributes
* Notes:
*======================================================
*/

class Student {
  String id;
  String icNo;
  String name;
  String className;

  Student({
    required this.id,
    required this.icNo, 
    required this.name, 
    required this.className,
    // this.gender
  });
}