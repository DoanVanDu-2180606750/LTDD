import 'package:flutter/material.dart';
import 'package:vincent/Screen/Home.dart';
import 'package:vincent/Screen/ResetPass.dart';
import 'package:vincent/Screen/SignIN.dart';
import 'package:vincent/Screen/SignUp.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(TravelApp());
}

class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      initialRoute: '/signin',
      routes: {
        '/home': (context) => HomeScreen(),
        '/signin' : (context) => SignInScreen(),
        '/signup' : (context) => SignUpScreen(),
        '/reset' : (context) => ResetPassScreen(),
      },
    );
  }
}

