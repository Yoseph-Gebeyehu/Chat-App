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
          SnackBar(content: Text(e.toString())),
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
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage(),
                              ),
                            );
                          },
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
                        SizedBox(width: deviceSize.width * 0.02),
                        InkWell(
                          onTap: widget.onTap,
                          child: Text(
                            'Register now',
                            style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: deviceSize.width * 0.036,
                              fontWeight: FontWeight.bold,
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

    // return Scaffold(
    //   body: SafeArea(
    //     child: Center(
    //       child: Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 20.0),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             const SizedBox(height: 50),
    //             // logo
    //             Icon(
    //               Icons.message,
    //               size: 100,
    //               color: Colors.grey[800],
    //             ),
    //             // welcome back message
    //             const Text(
    //               'Welcome back you\'ve been missed!',
    //               style: TextStyle(fontSize: 16),
    //             ),
    //             const SizedBox(height: 25),
    //             //email
    //             CustomTextField(
    //               controller: emailController,
    //               hintText: 'Email',
    //               obscureText: false,
    //             ),
    //             const SizedBox(height: 10),
    //             // password textfield
    //             CustomTextField(
    //               controller: passwordController,
    //               hintText: 'Password',
    //               obscureText: true,
    //             ),
    //             const SizedBox(height: 25),
    //             //signin button
    //             CustomButton(
    //                 onTap: () {
    //                   signIn();
    //                 },
    //                 text: 'Sign in'),
    //             const SizedBox(height: 50),
    //             // not a member? register now

    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 const Text('Not a member?'),
    //                 const SizedBox(width: 4),
    //                 GestureDetector(
    //                   onTap: widget.onTap,
    //                   child: const Text(
    //                     'Register',
    //                     style: TextStyle(
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
