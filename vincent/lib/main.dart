import 'package:flutter/material.dart';
import 'package:vincent/Screen/Home.dart';
import 'package:vincent/Screen/Main.dart';
import 'package:vincent/Screen/ResetPass.dart';
import 'package:vincent/Screen/SignIN.dart';
import 'package:vincent/Screen/SignUp.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  late bool? isSignedIn;
  if(prefs.getBool('isSignedIn') != null){
    isSignedIn = prefs.getBool('isSignedIn');
    print(isSignedIn);
  } else{
    isSignedIn = false;
  }
  runApp(TravelApp( isSignedIn: isSignedIn ?? false,));
}

final themeMode = ValueNotifier(2);
class TravelApp extends StatelessWidget {
  final bool isSignedIn;
  const TravelApp({super.key, required this.isSignedIn});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isSignedIn ? '/' : '/signin',
      routes: {
        '/': (context) => const MainScreen(),
        '/home': (context) => HomeScreen(),
        '/signin' : (context) => SignInScreen(),
        '/signup' : (context) => SignUpScreen(),
        '/reset' : (context) => ResetPassScreen(),
      },
    );
  }
}























