import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timesheet_proj/pages/timesheet_page.dart';

import '../login_page/colors.dart';
import '../login_page/login_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: CustomColor.indigoDark,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(80.0),
                  bottomRight: Radius.circular(80.0),
                ),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate to the next page using GetX
                      Get.to(TimesheetPage());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Center(
                        child: Text(
                          'JOYFYTECH',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        'TIMESHEET',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    ClipOval(
                      child: Image.asset(
                        "assets/images/jt_logo.png",
                        fit: BoxFit.cover,
                        width: 180,
                        height: 180,
                      ),
                    ),
                    LoginField(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
