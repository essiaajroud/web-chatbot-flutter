// Import necessary packages for making HTTP requests
import 'package:chatbot_ui/sign%20in/signin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import '../home/home.dart';
import '../logger_config.dart';
import 'package:get/get.dart';
import 'dart:convert';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final response = await http.post(
            Uri.parse('http://127.0.0.1:8000/api/register/'),
            headers: <String, String>{
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: {
              'username': _usernameController.text,
              'email': _emailController.text,
              'password': _passwordController.text,
              'confirm_password': _confirmPasswordController.text,
            });

        if (response.statusCode == 201) {
          // User registration successful
          final jsonResponse = json.decode(response.body);
          final authToken = jsonResponse['token'].toString();
          Get.to(() => MyHomePage(authToken: authToken));
        }
        if (response.statusCode == 400) {
         final errorResponse = json.decode(response.body);
        final errors = errorResponse['error'];

        // Check for specific error messages
        if (errors.containsKey('username') &&
            errors['username'].contains('A user with that username already exists.')) {
          // Display username exists error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Username already exists. Please choose a different one.'),
              duration: const Duration(seconds: 3),
            ),
          );
        } else if (errors.containsKey('password2') &&
            errors['password2'].contains('The password is too similar to the username.')) {
          // Display password similarity error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Password is too similar to the username. Choose a different one.'),
              duration: const Duration(seconds: 3),
            ),
          );
        } else {
          // Handle other validation errors
          print('Response Body: ${response.body}');
        }
      }
      } catch (error) {
        // Handle unexpected errors
        logger.warning('Unexpected error: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('An unexpected error occurred. Please try again. $error'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red[100],
        body: ListView(children: <Widget>[
          SizedBox(height: (MediaQuery.of(context).size.height / 2) - 200),
          Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 3,
                right: MediaQuery.of(context).size.width / 4,
              ),
              child: Stack(children: <Widget>[
                ClipPath(
                    clipper: RoundedDiagonalPathClipper(),
                    child: Container(
                        height: 400,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top:35),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 600,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: TextFormField(
                                    controller: _usernameController,
                                    decoration:
                                        const InputDecoration(labelText: 'Name'),
                                    validator: (value) {
                                      if (value?.isEmpty ?? true) {
                                        return 'Please enter your name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Container(
                                  width: 600,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: TextFormField(
                                    controller: _emailController,
                                    decoration:
                                        const InputDecoration(labelText: 'Email'),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value?.isEmpty == true ||
                                          value?.contains('@') != true) {
                                        return 'Please enter a valid email address';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Container(
                                  width: 600,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: TextFormField(
                                    controller: _passwordController,
                                    decoration: const InputDecoration(
                                        labelText: 'Password'),
                                    obscureText: true,
                                    validator: (value) {
                                      if (value == null ||
                                          value.length < 6 ||
                                          value.isEmpty) {
                                        return 'Password must be at least 6 characters long';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Container(
                                  width: 600,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: TextFormField(
                                    controller: _confirmPasswordController,
                                    decoration: const InputDecoration(
                                        labelText: 'Confirm Password'),
                                    obscureText: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please confirm your password';
                                      } else if (value !=
                                          _passwordController.text) {
                                        return 'Passwords do not match';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 35),
                                  child: Divider(
                                    color: Color.fromRGBO(0, 0, 0, 0.15),
                                    height: 1,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Padding(
                                        padding:
                                            EdgeInsets.only(left: 20, top: 14),
                                        child: Text("Already have an account ?",
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 13,
                                              color:
                                                  Color.fromARGB(255, 83, 82, 82),
                                            ))),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 17, top: 14),
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.to(() => const SignInScreen());
                                          },
                                          child: const Text('Sign In',
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  shadows: [
                                                    Shadow(
                                                      color: Colors.black,
                                                      blurRadius: 2,
                                                      offset: Offset(0, 0),
                                                    )
                                                  ])),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ))),
                SizedBox(
                  height: 420,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[900]),
                      child: const Text('Sign Up',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 60.0,
                      backgroundColor: Colors.grey[50],
                      child: Image.asset('assets/logo.png'),
                    ),
                  ],
                ),
              ]))
        ]));
  }
}
