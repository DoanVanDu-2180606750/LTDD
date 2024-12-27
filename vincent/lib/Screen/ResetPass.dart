import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResetPassScreen extends StatefulWidget {
  const ResetPassScreen({super.key});
  @override
  State<ResetPassScreen> createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _checkpass(){
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _resetPassword() async {

    // Kiểm tra tính hợp lệ của Form trước khi gọi API
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đang xử lý...')),
      );

      try {
        final response =
            await http.post(Uri.parse('http://192.168.1.7:8080/api/fogetpass'),
                headers: {
                  'Content-Type': 'application/json',
                },
                body: json.encode({
                  'email': _emailController.text,
                  'newpassword': _passwordController.text,
                }));

        if (response.statusCode == 200) {
          // Thành công, hiển thị thông báo
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Vui lòng xem mail để xác nhận mật khẩu!')),
          );
        } else {
          final responseBody = jsonDecode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  responseBody['error'] ?? 'Lỗi đặt lại mật khẩu, vui lòng thử lại'),
            ),
          );
        }
      } catch (e) {
        // Lỗi khi thực hiện yêu cầu (timeout, không có kết nối, v.v.)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: $e')),
        );
      }
    } else {
      // Nếu form không hợp lệ
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nhập đúng thông tin!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4CA1AF), Color(0xFFC4E0E5)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: SingleChildScrollView( 
              padding: const EdgeInsets.symmetric(horizontal: 30), 
              child: Column(
                children: [
                  const Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20), 
                  const Text(
                    "Enter your email below to receive a password reset link.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 30), 
        
                  // Trường nhập email
                  TextFormField(
                    controller: _emailController, 
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.email, color: Colors.grey),
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!regex.hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
        
                  // Trường nhập mật khẩu (nếu cần thiết)
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.password, color: Colors.grey), 
                      hintText: "New password",
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      suffixIcon: IconButton(
                        onPressed: _checkpass, 
                        icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off, color: Colors.grey)
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nhập mật khẩu'; 
                        }
                        if (value.length < 8) { 
                          return 'Mật khẩu trên 8 ký tự'; 
                        }
                        return null; // Nếu hợp lệ
                      },
                  ),
                  const SizedBox(height: 20),
        
                  // Nút gửi yêu cầu đặt lại mật khẩu
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => print("Reset Password Pressed"), // Hành động khi nhấn nút
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16), // Padding cho nút
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0), // Bo tròn góc cho nút
                        ),
                        backgroundColor: Colors.white, // Màu nền của nút
                      ),
                      child: const Text(
                        "Send Reset Link", // Nội dung của nút
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF4CA1AF), // Màu chữ
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
        
                  // Nút quay lại màn hình đăng nhập
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Quay lại màn hình trước
                    },
                    child: const Text(
                      "Back to Login",
                      style: TextStyle(color: Colors.white70), // Màu chữ cho nút
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
