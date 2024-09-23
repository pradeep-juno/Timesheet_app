import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timesheet_proj/login_page/trapezoid_clipper.dart';

import '../pages/create_account_page.dart';
import '../pages/timesheet_page.dart'; // Import TimesheetPage
import 'colors.dart';

class LoginField extends StatefulWidget {
  const LoginField({super.key});

  @override
  State<LoginField> createState() => _LoginFieldState();
}

class _LoginFieldState extends State<LoginField> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'LOGIN',
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: GoogleFonts.labrada(),
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      print('Email field is empty');
                      return 'Please enter an email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: GoogleFonts.labrada(),
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                          print('Password visibility toggled: $_isObscure');
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      print('Password field is empty');
                      return 'Please enter a password';
                    } else if (value.length < 6) {
                      print('Password is too short');
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      print('Login form is valid');
                      try {
                        // Firebase login logic
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                          email: _nameController.text,
                          password: _passwordController.text,
                        );
                        print(
                            'Login successful with email: ${_nameController.text}');

                        // Navigate to TimesheetPage
                        Get.snackbar(
                          'Success',
                          'Logged in successfully',
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        Get.off(
                            () => TimesheetPage()); // Navigate to TimesheetPage
                      } catch (e) {
                        print('Login failed: $e');
                        Get.snackbar(
                          'Error',
                          'Login failed. Please try again',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    } else {
                      print('Login form validation failed');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Log In',
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 80),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an account? ",
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: 'Sign up',
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('Navigating to sign-up page');
                              Get.to(
                                () => const CreateAccountPage(),
                                transition: Transition.downToUp,
                                duration: const Duration(milliseconds: 500),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
        ClipPath(
          clipper: TrapezoidClipper(),
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            color: CustomColor.indigoDark,
            child: Padding(
              padding: const EdgeInsets.only(top: 119),
              child: Center(
                child: Text(
                  "@Joyfytech Pvt Ltd",
                  style: GoogleFonts.abel(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
