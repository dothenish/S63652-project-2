/*=====================================================
* Program: log_in_page.dart
* Purpose: Create the login page
* Notes: Utilize firebaseAuth to handle authentication
*======================================================
*/

import 'package:flutter/material.dart';
import 'package:school_management_app/views/screens/dashboard_page.dart';
import 'package:school_management_app/views/widgets/login_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder<User?>( //listen for changes during authentication state.
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) { //if loading
          return const Center(
            child: CircularProgressIndicator()
          );
        } else if (snapshot.hasError) { //if error occured
          return const Center(
            child: Text("Error Occured!"));
        } 
        else if (snapshot.hasData) { //if authentication successful, return to dashboard page
          return const Dashboard();
        } else {
          return const LoginWidget();
        }
      },
    ),
  );
}