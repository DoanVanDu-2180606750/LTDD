import 'package:flutter/material.dart';
import 'package:vincent/Screen/Home.dart';
import 'package:vincent/Screen/Profile.dart';
import 'package:vincent/Screen/ResetPass.dart';
import 'package:vincent/Screen/SignIN.dart';
import 'package:vincent/Screen/SignUp.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isSignedIn = prefs.getBool('isSignedIn');
  runApp(TravelApp( isSignedIn: isSignedIn ?? false,));
}

class TravelApp extends StatelessWidget {
  final bool isSignedIn;
  const TravelApp({super.key, required this.isSignedIn});
  
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

