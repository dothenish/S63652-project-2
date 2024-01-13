// import 'package:flutter/material.dart';

// class MyWidget extends StatelessWidget {
//   const MyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

// Future<void> _pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

//     setState(() {
//       if (pickedFile != null) {
//         _imageUrl = pickedFile.path;
//       }
//     });
//   }

// Widget _buildImageContainer() {
//   return Container(
//       margin: const EdgeInsets.symmetric(vertical: 16.0),
//       height: 200,
//       width: 300,
//       decoration: BoxDecoration(
//         border: Border.all(
//           width: 3,
//           color: Colors.teal),
//           borderRadius: BorderRadius.circular(10.0)
//           ),
//           child: _imageUrl.isNotEmpty
//           ? Image.file(
//             File(_imageUrl),
//             fit: BoxFit.cover,
//             )
//             : const Column( //placeholder when no image is chosen
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.photo_library_outlined,
//                 size: 40
//                 ),
//                 SizedBox(height: 8.0),
//                 Text('Please upload an image')
//                 ],
//               ),
//           );
//         }