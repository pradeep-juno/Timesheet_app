import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:google_fonts/google_fonts.dart';
import 'package:timesheet_proj/pages/login_page.dart';

import '../login_page/colors.dart'; // Your custom color file

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true; // Password visibility toggle

  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth instance

  Future<void> _createAccount() async {
    print("Create Account button pressed");
    try {
      // Check if fields are empty
      if (_nameController.text.isEmpty ||
          _emailController.text.isEmpty ||
          _passwordController.text.isEmpty) {
        print("Fields are empty, showing error snackbar");
        Get.snackbar(
          'Error',
          'Please fill all the fields',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      print("Creating a new account with Firebase Auth");
      // Create a new user with Firebase Auth
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      print("Account created, updating display name");
      // Optional: Update the display name
      await userCredential.user?.updateDisplayName(_nameController.text);

      print("Account creation successful, showing success snackbar");
      Get.snackbar(
        'Success',
        'Account created successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );

      print("Navigating to LoginPage");
      // Navigate to the login page or the next page
      Get.off(() => const LoginPage());
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred, please try again.';
      if (e.code == 'email-already-in-use') {
        message = 'This email is already in use.';
        print("Error: email already in use");
      } else if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
        print("Error: weak password");
      } else if (e.code == 'invalid-email') {
        message = 'The email address is not valid.';
        print("Error: invalid email");
      }

      print("Error occurred during account creation, showing error snackbar");
      Get.snackbar(
        'Error',
        message,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/create_account.png', // Replace with your image path
                    width: 150,
                    height: 140,
                    fit: BoxFit.cover,
                    color: CustomColor.indigoDark,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 560,
                decoration: BoxDecoration(
                  color: CustomColor.indigoDark,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(80),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'CREATE ACCOUNT',
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: GoogleFonts.labrada(),
                          filled: true,
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
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
                              _isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                                print("Password visibility toggled");
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          print("Create Account button clicked");
                          _createAccount(); // Call _createAccount
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
                            'Create Account',
                            style: GoogleFonts.gabarito(
                              textStyle: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Have an account? ',
                                style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: 'Log In',
                                style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print("Log In link clicked");
                                    Get.to(() => const LoginPage());
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            print("Back button clicked");
                            Get.back(); // Navigate back
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.arrow_back_ios_rounded,
                                color: Colors.white,
                              ),
                              Text(
                                'Back',
                                style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
