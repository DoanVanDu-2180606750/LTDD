import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vincent/Component/buttonuser.dart';
import 'package:vincent/Model/user_model.dart';
import 'package:vincent/Service/authGg_service.dart';
import 'package:vincent/Service/getProfile_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = AuthGgService();
  final _getUser = UserService();

  User? _user;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      User? user = await _getUser.getUserProfile();
      if (user != null) {
        setState(() {
          _user = user;
        });
      } else {
        log("Không thể tải thông tin người dùng.");
      }
    } catch (error) {
      log("Lỗi khi tải dữ liệu: $error");
    }
  }

  Future<void> _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await _auth.signOut();
      await prefs.setBool('isSignedIn', false);
      await prefs.setString('token', '');

      // Chuyển hướng người dùng về màn hình đăng nhập
      Navigator.pushReplacementNamed(context, '/signin');
    } catch (e) {
      log("Lỗi khi đăng xuất: $e");
      // Thông báo lỗi cho người dùng
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Thông tin người dùng'),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.transparent,
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    // ignore: unnecessary_null_comparison
                    backgroundImage: _user?.image != null ? NetworkImage(_user!.image!)
                    : AssetImage('assets/images/User.jpg'),
                  ),
                  Text(
                    _user?.name ?? 'N/A',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _user?.email ?? 'N/A',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  CustomButtonUser (
                    icon: Icons.edit,
                    onTap: () { 
                      Navigator.pushNamed(context, '/edit-profile');
                    },
                    title: 'Chỉnh sửa thông tin',
                  ),
                  SizedBox(height: 20),
                  CustomButtonUser (
                    icon: Icons.security,
                    onTap: () { log('ok');},
                    title: 'Bảo mật',
                  ),
                  SizedBox(height: 20),
                  CustomButtonUser (
                    icon: Icons.history,
                    onTap: () { log('ok');},
                    title: 'Lịch sử',
                  ),
                  SizedBox(height: 20),
                  CustomButtonUser (
                    icon: Icons.help,
                    onTap: () { log('ok');},
                    title: 'Help',
                  ),
                  SizedBox(height: 20),
                  CustomButtonUser (
                    icon: Icons.logout,
                    onTap: _logout,
                    title: 'Đăng xuất',
                  ),    
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
