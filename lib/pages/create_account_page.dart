import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX package
import 'package:google_fonts/google_fonts.dart';

import '../login_page/colors.dart';

// A simple data store to hold user credentials (this is just for demonstration purposes)
final Map<String, String> userDatabase =
    {}; // This will hold names and passwords

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;

  // Show error message
  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );

    // Clear the text fields after showing the snackbar
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
  }

  // Validate name format
  bool _isValidName(String name) {
    return RegExp(r'^[a-zA-Z]+(?: [a-zA-Z]+)+$').hasMatch(name);
  }

  // Validate email format
  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
  }

  // Validate password format
  bool _isValidPassword(String password) {
    return password.length >= 8 &&
        RegExp(r'[A-Za-z]').hasMatch(password) &&
        RegExp(r'[0-9]').hasMatch(password) &&
        RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
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
                      Form(
                        key: _formKey,
                        child: Column(
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
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !_isValidName(value)) {
                                  return 'Please enter a valid name (e.g., Pradeep S)';
                                }
                                return null;
                              },
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
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !_isValidEmail(value)) {
                                  return 'Please enter a valid email';
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
                                    _isObscure
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !_isValidPassword(value)) {
                                  return 'Password must be at least 8 characters with letters, numbers, and special characters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  // Store user data
                                  userDatabase[_nameController.text] =
                                      _passwordController.text;

                                  Get.snackbar(
                                    'Success',
                                    'Account created successfully!',
                                    snackPosition: SnackPosition.BOTTOM,
                                  );

                                  // Clear text fields after successful account creation
                                  _nameController.clear();
                                  _emailController.clear();
                                  _passwordController.clear();
                                } else {
                                  _showErrorSnackbar(
                                      'Please fill in all the fields correctly.');
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.orange,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
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
                                          Get.back();
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
                                  Get.back(); // Navigate to the login page
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
