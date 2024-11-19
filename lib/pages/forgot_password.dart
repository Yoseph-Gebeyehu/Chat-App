import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/custom_button.dart';
import '../components/custom_dialog.dart';
import '../components/custom_text_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  // Controller for email
  final emailController = TextEditingController();

  // Method to reset password
  void resetPassword() async {
    // Show loading indicator
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).primaryColorDark,
        ),
      ),
    );

    try {
      // Send password reset email
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );

      // Close loading indicator
      Navigator.pop(context);

      // Show success dialog
      CustomDialog.showSuccess(
        context: context,
        title: 'Success',
        desc: 'Password reset email has been sent!',
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Close loading indicator

      // Show error dialog based on the error code
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found with this email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Please enter a valid email address.';
      } else {
        errorMessage = 'Something went wrong. Please try again later.';
      }

      CustomDialog.showError(
        context: context,
        title: 'Error',
        desc: errorMessage,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Column(
          children: [
            AppBar(
              title: const Text("Forgot Password"),
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            const Divider(
              color: Colors.black,
              thickness: 0.2,
              height: 1,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: deviceSize.width * 0.08),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: deviceSize.height * 0.02),
                  Image.asset(
                    'assets/chat.png',
                    height: deviceSize.height * 0.22,
                    fit: BoxFit.cover,
                  ),

                  // Instruction Text
                  Text(
                    'Enter your email and we will send you a link to reset your password.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: deviceSize.width * 0.04,
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.03),

                  // Email TextField
                  CustomTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  SizedBox(height: deviceSize.height * 0.03),

                  // Reset Password Button
                  CustomButton(
                    onTap: resetPassword,
                    text: 'Reset Password',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
