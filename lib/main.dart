import 'dart:convert';

import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/new/controllers/auth_service.dart';
import 'package:chat_app/new/controllers/notification_service.dart';
import 'package:chat_app/new/views/login_page.dart';
import 'package:chat_app/new/views/message.dart';
import 'package:chat_app/new/views/signup_page.dart';
import 'package:chat_app/new/views/home_page.dart';
// import 'package:chat_app/services/auth/auth_gate.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();

// function to listen background changes
Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print('Some notification Received in background...');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // initialize firebase messaging
  await PushNotifications.init();

  // initialize local notification
  await PushNotifications.localNotInit();

  // Listen to background notification
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  // on background notification tapped
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print('Background Notification tapped in');
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    }
  });

  // on background notification tapped
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
  });

  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFf0c0bf),
        primaryColor: const Color(0xfffaf6f1),
        primaryColorDark: const Color.fromARGB(255, 164, 98, 17),
        fontFamily: 'Arima',
      ),
      debugShowCheckedModeBanner: false,
      // home: const AuthGate(),

      routes: {
        "/": (context) => const CheckUser(),
        "/login": (context) => const LoginPage(),
        "/signup": (context) => const SignupPage(),
        "/home": (context) => const HomePage(),
        "/message": (context) => const MessagePage(),
      },
    );
  }
}

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  void initState() {
    AuthNewService.isLoggedIn().then(
      (value) {
        if (value) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
