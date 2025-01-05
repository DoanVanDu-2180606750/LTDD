

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:vincent/Screen/EditProfile.dart';
import 'package:vincent/Screen/Home.dart';
import 'package:vincent/Screen/HomeBooking.dart';
import 'package:vincent/Screen/HomeDetails.dart';
import 'package:vincent/Screen/Recently.dart';
import 'package:vincent/Screen/Main.dart';
import 'package:vincent/Screen/ResetPass.dart';
import 'package:vincent/Screen/SignIn.dart';
import 'package:vincent/Screen/SignUp.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseAuth.instance.setLanguageCode("en");
  
  await dotenv.load(fileName: ".env");

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isSignedIn = prefs.getBool('isSignedIn') ?? false;

  runApp(TravelApp(isSignedIn: isSignedIn));
}

final themeMode = ValueNotifier(2);

class TravelApp extends StatelessWidget {
  final bool isSignedIn;
  
  const TravelApp({super.key, required this.isSignedIn});
  
  @override
  Widget build(BuildContext context) {
    final apiUrl = dotenv.get('API_URL');
    log(apiUrl);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isSignedIn ? '/' : '/signin',
      themeMode: themeMode.value == 1 ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      routes: {
        '/': (context) => const MainScreen(),
        '/home': (context) => HomeScreen(),
        '/signin': (context) => SignInScreen(),
        '/signup': (context) => SignUpScreen(),
        '/reset': (context) => ResetPassScreen(),
        '/recently-home': (context) => const RecentlyScreen(),
        '/home-booking': (context) => const HomeBookingScreen(),
        '/edit-profile': (context) => const EditProfileScreen(),
      },
    );
  }
}

