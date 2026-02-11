
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'map_screen.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Family Tracker Login")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: passController, decoration: InputDecoration(labelText: "Password"), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var user = await _auth.login(emailController.text, passController.text);
                if (user != null) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => MapScreen()));
                }
              },
              child: Text("Login"),
            ),
            ElevatedButton(
              onPressed: () async {
                var user = await _auth.register(emailController.text, passController.text);
                if (user != null) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => MapScreen()));
                }
              },
              child: Text("Register"),
            )
          ],
        ),
      ),
    );
  }
}
