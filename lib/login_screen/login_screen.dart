
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:timesheet_management/dashboard/dashboard.dart';
import 'package:timesheet_management/utils/api/post_api.dart';

class LoginScreen extends StatefulWidget {


  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:  const BoxDecoration(
          gradient: LinearGradient(
            colors: [

              Color(0xff89B9E1),
              Color(0xffb4ceee),
              Colors.white,
              Colors.white,
              Color(0xffa2a1a1),

              ], // Define gradient colors
            begin: Alignment.centerLeft, // Start position of the gradient
            end: Alignment.bottomLeft, // End position of the gradient
          ),
        ),
        child: Stack(
          children: [

            Center(
              child: SingleChildScrollView(
                child: Card(elevation: 10,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Logo Section
                        Container(
                          height: 100,
                          width: 350,
                          decoration: const BoxDecoration(
                            //  color:Colors.black,
                            gradient: LinearGradient(
                              colors: [
                                Color(0xffB2B5C4),

                                Color(0xff565555),
                                Color(0xffB2B5C4),

                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,

                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("assets/logo/SAP_logo.png"),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Welcome Text
                        Text(
                          'Welcome',
                          style: TextStyle(
                            fontSize: 30, // Slightly larger font size for emphasis
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = const LinearGradient(
                              colors: [
                                // Color(0xFFA54AE2), // Light blue
                                // Color(0xFF145DA0),
                                // Color(0xFFFF8C42), // Vibrant Orange
                                Color(0xd7f69aa5), // Darker blue
                                Color(0xd7000000), // Darker blue
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(const Rect.fromLTWH(0.0, 0.0, 100.0, 70.0)),
                            shadows: const [
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 2.0,
                                color: Colors.black26, // Subtle shadow for depth
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),
                        Text(
                          'Please login to continue',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Email Input Field
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'User Name',
                            prefixIcon: const Icon(Icons.email, color: Colors.blueAccent),
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20),
                        // Password Input Field
                        TextField(
                          controller: passwordController,
                          obscureText: !_isPasswordVisible, // Toggles password visibility
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock, color: Colors.blueAccent),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                color: Colors.blueAccent,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        // Forgot Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              print('Forgot Password Clicked');
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.blueAccent.shade700),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF4A90E2), // Light blue
                                  Color(0xFF145DA0),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ElevatedButton(
                              onPressed: () async {
                                print(emailController.text);
                                print(passwordController.text);
                                Map json ={
                                  "user_name":emailController.text,
                                  "password":passwordController.text
                                };
                                await checkLoginDetails(requestBody:json);


                                // _handleLogin();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent, // Transparent to let the gradient show
                                shadowColor: Colors.transparent, // No shadow behind
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: const Text(
                                'Log In',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  checkLoginDetails({required  requestBody}) async {
    String url ="https://6dtechnologies.cfapps.us10-001.hana.ondemand.com/api/usermaster/login-authenticate";
    var data =await postData(url: url,requestBody: requestBody,context: context);
    if(data!=null){
      print(data);
      window.sessionStorage["login"] = "success";
      window.sessionStorage["userType"] = data['role'];
      Navigator.pushNamed(context, "/dashboard");
    }

  }
}