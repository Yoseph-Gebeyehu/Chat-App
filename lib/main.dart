import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/services/auth/auth_gate.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFf0c0bf),
        primaryColor: const Color(0xfffaf6f1),
        primaryColorDark: const Color.fromARGB(255, 164, 98, 17),
        fontFamily: 'Arima',
      ),
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
    );
  }
}
