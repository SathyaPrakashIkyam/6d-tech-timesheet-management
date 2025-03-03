import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.blue.shade900,
        actions: [ Image.asset("assets/logo/sap.png", width: 80),],
      ),
      body: Stack(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [// Left Side - Login Form
              Center(
                child: Container(
                  padding: const EdgeInsets.all(30),
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Log In",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const TextField(
                        decoration: InputDecoration(
                          labelText: "Email ID",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade900,
                          ),
                          onPressed: () {},
                          child: const Text("Login"),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text.rich(
                        TextSpan(
                          text: "Don't have an account? ",
                          children: [
                            TextSpan(
                              text: "Create Account",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 300,width: 100,),
              // Right Side - Illustration
              Center(
                child: Stack(
                  children: [
                    Image.asset("assets/logo/illustration.png", width: 400),

                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
