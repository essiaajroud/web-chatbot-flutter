import 'package:chatbot_ui/sign%20up/signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../home/home.dart';
import '../logger_config.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'dart:convert';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await http.post(
            Uri.parse('http://127.0.0.1:8000/api/login/'),
            headers: <String, String>{
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: {
              'email': _emailController.text,
              'password': _passwordController.text,
            });

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          final authToken = jsonResponse['token'].toString();
          Get.to(() => MyHomePage(authToken: authToken));
        } else {
          final errorResponse = json.decode(response.body);
          final errorMessage =
              errorResponse['error'] ?? 'Sign-in failed. Please try again.';
          logger.warning('Sign-in failed. Error: $errorMessage');
        }
      } catch (error) {
        logger.warning('Sign-in failed. Error: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      body: ListView(
        children: <Widget>[
          SizedBox(height: (MediaQuery.of(context).size.height / 2) - 200),
          Container(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 3,
              right: MediaQuery.of(context).size.width / 4,
            ),
            child: Stack(
              children: <Widget>[
                ClipPath(
                  clipper: RoundedDiagonalPathClipper(),
                  child: Container(
                      height: 400,
                      padding: const EdgeInsets.only(
                          top: 30, right: 10, left: 10, bottom: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 35),
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
                                    controller: _emailController,
                                    decoration: const InputDecoration(
                                      labelText: 'Email address',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your Email';
                                      }
                                      return null;
                                    },
                                    /* onSaved: (value) {
                                      _email = value;
                                    },*/
                                  ),
                                ),
                                Container(
                                  width: 600,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: TextFormField(
                                    controller: _passwordController,
                                    decoration: const InputDecoration(
                                      labelText: 'Password',
                                    ),
                                    obscureText: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      return null;
                                    },
                                    /*onSaved: (value) {
                                      _password = value;
                                    },*/
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 90),
                                  child: Divider(
                                    color: Color.fromRGBO(0, 0, 0, 0.15),
                                    height: 1,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Padding(
                                        padding:
                                            EdgeInsets.only(left: 20, top: 20),
                                        child: Text("Don't have an account ?",
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 13,
                                              color: Color.fromARGB(
                                                  255, 83, 82, 82),
                                            ))),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 17, top: 14),
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.to(() => const SignUpForm());
                                          },
                                          child: const Text('Sign Up',
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
                              ]),
                        ),
                      )),
                ),
                SizedBox(
                  height: 420,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: _signIn,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[900]),
                      child: const Text('Sign In',
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
