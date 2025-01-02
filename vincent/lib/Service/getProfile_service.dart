import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vincent/Model/user_model.dart';
const String _baseUrl = '10.10.62.49';

class UserService {

  final String _profileUrl = 'http://${_baseUrl}:8080/api/users/me';
  final String _editUrl = 'http://${_baseUrl}:8080/api/users/me';

  Future<User?> getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('token');
    
    if (userToken == null) {
      log("Token not found.");
      return null;
    }

    try {
      final response = await http.get(
        Uri.parse(_profileUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return User.fromJson(jsonData);
      } else {
        log('Error fetching data: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (error) {
      log("Error making request: ${error.toString()}");
      return null;
    }
  }

  // Update user information
  Future<User?> updateUserProfile({
    required String name,
    required String email,
    required String phone,
    required String nationalId,
    String? role,
    String? gender,
    String? address,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('token');

    if (userToken == null) {
      log("Token not found.");
      return null;
    }

    try {
      final response = await http.put(
        Uri.parse(_editUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'phone': phone,
          'nationalId': nationalId,
          'gender': gender,
          'address': address,
        }),
      );

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        log('Error updating user profile: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (error) {
      log("Error making request: ${error.toString()}");

      return null;
    }
  }

  Future<String> uploadImage(File image) async {

    final request = http.MultipartRequest('POST', Uri.parse(_editUrl));
    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      log(response.statusCode.toString());
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonResponse = json.decode(responseString);

      return jsonResponse['imageUrl'];
    } else {
      throw Exception('Failed to upload image');
    }
  }
}
