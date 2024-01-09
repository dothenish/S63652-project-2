import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   final TextEditingController _emailController = TextEditingController();
   final TextEditingController _passwordController = TextEditingController();

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
                controller: _passwordController,
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
                controller: _emailController,
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
              onPressed: navigateToDashboard, 
              child: const Text('LOGIN'))
          ],
        ),
      ),
    );
  }
}