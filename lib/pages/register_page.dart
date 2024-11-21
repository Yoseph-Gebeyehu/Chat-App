import 'package:chat_app/components/custom_button.dart';
import 'package:chat_app/google_service.dart';
import 'package:chat_app/square_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_text_field.dart';
import '../services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key, required this.onTap});
  final Function()? onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();
  bool isLoading = false;

  // Sign user in method
  void signUp() async {
    if (passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        emailController.text.isNotEmpty) {
      if (passwordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).primaryColorDark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            content: Text(
              'Password don\'t match!',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
        return;
      }
      // get auth service
      final authService = Provider.of<AuthService>(context, listen: false);

      try {
        await authService.signUpWithEmailAndPassword(
          emailController.text,
          passwordController.text,
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).primaryColorDark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            content: Text(
              e.toString(),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() => isLoading = true);

    await GoogleService().signInWithGoogle();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColor,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    SizedBox(height: deviceSize.height * 0.02),
                    Image.asset(
                      'assets/chat.png',
                      height: deviceSize.height * 0.22,
                      fit: BoxFit.cover,
                    ),

                    Text(
                      'Let\'s create an account for you!',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: deviceSize.width * 0.045,
                      ),
                    ),
                    SizedBox(height: deviceSize.height * 0.05),

                    CustomTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                    ),
                    SizedBox(height: deviceSize.height * 0.02),
                    CustomTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),
                    SizedBox(height: deviceSize.height * 0.02),
                    CustomTextField(
                      controller: confirmPasswordController,
                      hintText: 'Confirm Password',
                      obscureText: true,
                    ),
                    SizedBox(height: deviceSize.height * 0.02),

                    // Sigin in buttom
                    CustomButton(
                      onTap: signUp,
                      text: 'Sign up',
                    ),
                    SizedBox(height: deviceSize.height * 0.05),

                    // or continue with
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: deviceSize.width * 0.07,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: deviceSize.width * 0.05,
                            ),
                            child: Text('Or continue with'),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: deviceSize.width * 0.05),
                    // google + apple sign in buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SquareTitle(
                          imagePath: 'assets/google.png',
                          onTap: _signInWithGoogle,
                        ),
                        SizedBox(width: deviceSize.width * 0.1),
                        SquareTitle(
                          imagePath: 'assets/apple.png',
                          onTap: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: deviceSize.width * 0.05),
                    // not a member? register now
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: deviceSize.width * 0.036,
                          ),
                        ),
                        SizedBox(width: deviceSize.width * 0.02),
                        InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            widget.onTap!();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: Text(
                              'Login now',
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: deviceSize.width * 0.036,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (isLoading)
              Container(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
