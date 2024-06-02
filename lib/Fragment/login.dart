import 'package:flutter/material.dart';
import 'package:portfolio/main.dart';
// import 'home_page.dart';
// import 'apps.dart'; 

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                  labelStyle: TextStyle(color: Colors.blueGrey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  prefixIcon: const Icon(Icons.person, color: Colors.blueGrey),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a username";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20), // Add vertical spacing
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.blueGrey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  prefixIcon: const Icon(Icons.lock, color: Colors.blueGrey),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a password";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20), // Add vertical spacing
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (_usernameController.text == "zidan" &&
                        _passwordController.text == "1234") {
                      // Login logic here
                      print("Login successful!");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeActivity()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Invalid username or password"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: const Text("Login"),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue, // Text color
                    ),
                    onPressed: () {
                      // Handle register button press
                      print("Register button pressed");
                    },
                    child: const Text("Register?"),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue, // Text color
                    ),
                    onPressed: () {
                      // Handle social media login button press
                      print("Login through social media button pressed");
                    },
                    child: const Text("Login through social media"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
