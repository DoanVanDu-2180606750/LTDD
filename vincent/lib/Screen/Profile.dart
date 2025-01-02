import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vincent/Model/user_model.dart';
import 'package:vincent/Screen/EditProfile.dart';
import 'package:vincent/Service/authGg_service.dart';
import 'package:vincent/Service/getProfile_service.dart';
import 'package:vincent/Widgets/profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = AuthGgService();
  final _getUser = UserService();

  User? _user;

  Future<void> _loadData() async {
    try {
      User? user = await _getUser.getUserProfile();
      if (user != null) {
        setState(() {
          _user = user;  // Lưu thông tin người dùng để sử dụng trong UI
        });
      } else {
        // Nếu không có dữ liệu, xử lý lỗi hoặc thông báo cho người dùng
        log("Không thể tải thông tin người dùng.");
      }
    } catch (error) {
      log("Lỗi khi tải dữ liệu: $error");
      // Hiện thị thông báo cho người dùng
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
  void initState() {
    super.initState();
    _loadData();
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
                  subtitle: _user?.name ?? 'N/A',
                ),
                const SizedBox(height: 20),
                ProfileWidget.buildInforCard(
                  Icons.email,
                  'Email:', 
                  subtitle: _user?.email ?? 'Chưa có thông tin',
                ),
                const SizedBox(height: 20),
                ProfileWidget.buildInforCard(
                  Icons.add_ic_call_outlined,
                  'Phone:', 
                  subtitle: _user?.phone ?? 'Chưa có thông tin',
                ),
                const SizedBox(height: 20),
                ProfileWidget.buildInforCard(
                  Icons.assignment_ind,
                  'CCCD/CDMD:', 
                  subtitle: _user?.gender ?? 'Chưa có thông tin',
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
                  }, 
                  style: ElevatedButton.styleFrom(
                    overlayColor: Colors.red,
                    side: const BorderSide(color: Colors.blue, width: 1.0),
                    minimumSize: const Size(150, 40),
                  ),
                  child: const Text('Sửa thông tin', style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
                ElevatedButton(
                  onPressed: _logout,
                  style: ElevatedButton.styleFrom(
                    overlayColor: Colors.red,
                    side: const BorderSide(color: Colors.blue, width: 1.0),
                  ),
                  child: const Text('Đăng Xuất', style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
