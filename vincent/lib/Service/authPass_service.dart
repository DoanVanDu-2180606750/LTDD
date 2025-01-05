import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vincent/Model/user_model.dart';
const String _baseUrl = '10.10.62.49';

class AuthpassService {

  final String apiUrlSignIn = 'http://${_baseUrl}:8080/api/login';

  final String apiUrlSignUp = 'http://${_baseUrl}:8080/api/register';

  final String apiUrlResetPass = 'http://${_baseUrl}:8080/api/fogetpass';

  // Đặng nhập bằng tài khoản 
  Future<User?> signInAccount(String email, String password) async {
    try {

      final response = await http.post( 
        Uri.parse(apiUrlSignIn),
        headers: {
          'Content-Type': 'application/json'
        },
        body: json.encode({
          'email': email, 
          'password': password,
        }),
      );
      
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final userData = jsonResponse['user'];
        final String token = jsonResponse['token'];

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        log('Đang nhập thành công! User: $jsonResponse');
        return User.fromJson(userData);
      } else {
        final errorResponse = json.decode(response.body);
        String errorMessage = errorResponse['Thông báo!'] ?? 'Đăng nhập thất bại!';
        log("Lỗi đăng nhập: $errorMessage");
        throw Exception(errorMessage);
      }
    } catch (e) {
      log("Lỗi khi đăng nhập: ${e.toString()}");
      throw Exception("Lỗi khi đăng nhập:${e.toString()}");
    }
  }

  // Đăng ký tài khoản
  Future<User?> signUpAccount(String name, String email, String password) async {

    try {
      final response = await http.post(
        Uri.parse(apiUrlSignUp),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
       log('Đăng ký thành công! $name');
       return User.fromJson(jsonDecode(response.body)['user']);
      } else {
        log('Phản hồi lỗi: ${response.body}');
      }
    } catch (e) {
      log('Lỗi: $e');
    }
    return null; 
  }      

  // Đặt lại mật khẩu
  Future<User?> resetPassword(String email, String newpassword) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrlResetPass),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'newPassword': newpassword,
        })
      );

      if (response.statusCode == 200) {
        log('Đặt lại mật khẩu thành công!');
        return User.fromJson(jsonDecode(response.body)['user']);
      } else {
        final responseBody = jsonDecode(response.body);
        log('Phản hồi lỗi: $responseBody');
      }
    } catch (e) {
      log('Lỗi: $e');
    }
    return null;
  }
}
  