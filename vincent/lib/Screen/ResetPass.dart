import 'package:flutter/material.dart';
import 'package:vincent/Model/user_model.dart';
import 'package:vincent/Service/authPass_service.dart';

class ResetPassScreen extends StatefulWidget {

  const ResetPassScreen({super.key});
  @override
  State<ResetPassScreen> createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  final _formKey = GlobalKey<FormState>();
  final authPass = AuthpassService();
  bool _obscureText = true;

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void _checkpass(){
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _resetPassword() async {
    String email = _email.text;
    String newpassword = _password.text;

    if (_formKey.currentState!.validate()) {
      // Nếu Form hợp lệ, gọi API
      User? user =  await authPass.resetPassword(email, newpassword);
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Reset password thành công')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Reset password thất bại')));
      }
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
        
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _email, 
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
                          controller: _password,
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
                      ]
                    )
                  ),
                  
                  const SizedBox(height: 20),
        
                  // Nút gửi yêu cầu đặt lại mật khẩu
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _resetPassword(), 
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        "Send Reset Link",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF4CA1AF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
        
                  // Nút quay lại màn hình đăng nhập
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Back to Login",
                      style: TextStyle(color: Colors.white70),
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
