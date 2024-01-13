import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:school_management_app/main.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
   final emailController = TextEditingController();
   final passwordController = TextEditingController();

   @override
   void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
   }

  void navigateToDashboard() {
    Navigator.pushReplacementNamed(context, '/dashboard');
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Administrator \nLogin",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30
            ),),
            const SizedBox(height: 25,),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5
              ),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.purple[100],
                borderRadius: BorderRadius.circular(29),
              ),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  icon: Icon(Icons.person,
                  color: Colors.deepPurple[800]),
                  hintText: 'Email',
                  border: InputBorder.none),
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5
              ),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.purple[100],
                borderRadius: BorderRadius.circular(29),
              ),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock,
                  color: Colors.deepPurple[800]),
                  hintText: 'Password',
                  border: InputBorder.none),
              ),
            ),

            //Login Button
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0), 
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, 
                    vertical: 16.0),
                    minimumSize: const Size(200.0, 40.0),
                    ),
              onPressed: signIn, 
              child: const Text('Sing In'))
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator())
        );
    try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  } on FirebaseAuthException catch (e) {
    print(e);
  }
  navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}