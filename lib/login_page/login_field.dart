import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timesheet_proj/login_page/trapezoid_clipper.dart';

import '../pages/create_account_page.dart';
import '../pages/timesheet_page.dart';
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
  String? _name, _password;

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      borderRadius: 8,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );

    // Clear the text fields after showing the snackbar
    _nameController.clear();
    _passwordController.clear();
  }

  bool _isValidCredentials(String name, String password) {
    return userDatabase[name] == password;
  }

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
                    textStyle: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 30),
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
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value;
                  },
                ),
                SizedBox(height: 20),
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
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value;
                  },
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();

                      if (_isValidCredentials(_name!, _password!)) {
                        // Navigate to the TimesheetPage using GetX
                        Get.to(() => TimesheetPage());
                      } else {
                        // Show error snackbar if credentials are not valid
                        _showErrorSnackbar('Invalid name or password');
                      }
                    } else {
                      // Show error snackbar if the form is not valid
                      _showErrorSnackbar(
                          'Please enter valid name and password');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Log In',
                      style: GoogleFonts.gabarito(
                        textStyle: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 80),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an account? ",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: 'Sign up',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(
                                () => CreateAccountPage(),
                                transition: Transition.downToUp,
                                duration: const Duration(milliseconds: 500),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
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
                    textStyle: TextStyle(
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
