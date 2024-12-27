import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vincent/Screen/EditProfile.dart';
import 'package:vincent/Widgets/profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = true;

  Future <void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoading = false;
    });
  }

  Future <void> _Logout() async {
    // await FirebaseAuth.instance.signOut();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSignedIn', false);
    Navigator.pushReplacementNamed(context, '/signin');
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Thông tin người dùng'),
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage('https://picsum.photos/300/306'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ProfileWidget.buildInforCard(
                  Icons.person,
                  'Họ và tên:', 
                  subtitle: 'Đoàn Văn Dự', 
                ),
                const SizedBox( height: 20 ),
                ProfileWidget.buildInforCard(
                  Icons.email,
                  'Email:', 
                  subtitle: 'vandu21022003@gmail.com', 
                ),
                const SizedBox( height: 20 ),
                ProfileWidget.buildInforCard(
                  Icons.add_ic_call_outlined,
                  'Phone:', 
                  subtitle: '0339455501', 
                ),
                const SizedBox( height: 20 ),
                ProfileWidget.buildInforCard(
                  Icons.assignment_ind,
                  'CCCD/CDMD:', 
                  subtitle: '4095674938576', 
                ),
                const SizedBox(height: 20),
                ElevatedButton (
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
                  }, 
                  style: ElevatedButton.styleFrom(
                    overlayColor: Colors.red,
                    side: BorderSide(color: Colors.blue, width: 1.0),
                    minimumSize: const Size(150, 40),
                  ),
                  child: const Text('Sửa thông tin', style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
                ElevatedButton (
                  onPressed: () => _Logout(),
                  style: ElevatedButton.styleFrom(
                    overlayColor: Colors.red,
                    side: BorderSide(color: Colors.blue, width: 1.0),
                  ),
                  child: const Text('Đăng Xuất', style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
              ]
            )
          ),
        ),
      )
    );
  }
}
