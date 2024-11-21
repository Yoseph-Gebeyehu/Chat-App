import 'package:chat_app/components/custom_button.dart';
import 'package:chat_app/components/custom_text_field.dart';
import 'package:chat_app/google_service.dart';
import 'package:chat_app/pages/forgot_password.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/square_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign in user
  void signIn() async {
    // get the auth service
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      final authService = Provider.of<AuthService>(context, listen: false);

      try {
        await authService.signInWithEmailandPassword(
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

  bool isLoading = false;

  Future<void> _signInWithGoogle() async {
    setState(() => isLoading = true);

    await GoogleService().signInWithGoogle();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
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
                    SizedBox(height: deviceSize.height * 0.02),
                    Image.asset(
                      'assets/chat.png',
                      height: deviceSize.height * 0.22,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      'Welcome back you\'ve been missed!',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: deviceSize.width * 0.045,
                      ),
                    ),
                    SizedBox(height: deviceSize.height * 0.05),
                    CustomTextField(
                      controller: emailController,
                      hintText: 'Username',
                      obscureText: false,
                    ),
                    SizedBox(height: deviceSize.height * 0.02),
                    CustomTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),
                    SizedBox(height: deviceSize.height * 0.01),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordPage(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: deviceSize.height * 0.02),
                    CustomButton(
                      onTap: signIn,
                      text: 'Sign in',
                    ),
                    SizedBox(height: deviceSize.height * 0.05),
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
                            child: const Text('Or continue with'),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Not a member?',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: widget.onTap,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: Text(
                              'Register now',
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
