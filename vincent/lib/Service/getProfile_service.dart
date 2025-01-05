import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vincent/Model/user_model.dart';

const String _baseUrl = '10.10.62.49';

class UserService {
  final String _profileUrl = 'http://$_baseUrl:8080/api/users/me';
  final String _editUrl = 'http://$_baseUrl:8080/api/users/me';

  Future<User?> getUserProfile() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userToken = prefs.getString('token');

      if (userToken == null) {
        log("Token not found.");
        return null;
      }

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

  Future<User?> updateUserProfile({
  required String name,
  required String email,
  required String phone,
  required String nationalId,
  File? image,
  String? role,
  String? gender,
  String? address,
}) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('token');

    if (userToken == null) {
      log("Token not found.");
      return null;
    }

    // Create multipart request
    var request = http.MultipartRequest('PUT', Uri.parse(_editUrl))
      ..headers['Authorization'] = 'Bearer $userToken';

    // Add field data as multipart fields
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['phone'] = phone;
    request.fields['nationalId'] = nationalId;
    if (gender != null) request.fields['gender'] = gender;
    if (address != null) request.fields['address'] = address;
    
    // Add image file, if provided
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image', 
        image.path,
        filename: image.path.split('/').last,
      ));
    }

    // Send request
    var response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await http.Response.fromStream(response);
      return User.fromJson(jsonDecode(responseData.body));
    } else {
      log('Error updating user profile: ${response.statusCode} - ${response.reasonPhrase}');
      return null;
    }
  } catch (error) {
    log("Error making request: ${error.toString()}");
    return null;
  }
}

}
