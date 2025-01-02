import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vincent/Model/user_model.dart';
import 'package:vincent/Service/getProfile_service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final UserService _upData = UserService();
  File? _image;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nationalIdController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nationalIdController.dispose();
    _imageController.dispose();
    _roleController.dispose();
    _genderController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  // Function to pick image from the gallery
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path); // Save the image path
      });
    }
  }

  Future<void> _loadUserProfile() async {

    User? user = await _upData.getUserProfile();
    if (user != null) {
      _nameController.text = user.name ?? '';
      _emailController.text = user.email;
      _phoneController.text = user.phone ?? '';
      _nationalIdController.text = user.nationalid ?? '';
      _imageController.text = user.image ?? '';
      _roleController.text = user.role;
      _genderController.text = user.gender;
      _addressController.text = user.address ?? '';
    }
  }

  Future<void> _updateProfile() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;
    String nationalId = _nationalIdController.text;
    String gender = _genderController.text;
    String address = _addressController.text;

    if(_image != null) {
      // Upload the image to the server
      String image = await _upData.uploadImage(_image!);
      _imageController.text = image;
    }

    User? updatedUser = await _upData.updateUserProfile(
      name: name,
      email: email,
      phone: phone,
      nationalId: nationalId,
      gender: gender,
      address: address,
    );

    if (updatedUser != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade100,
                    Colors.deepPurple.shade50,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: _image != null ? FileImage(_image!) : AssetImage('assets/images/User.jpg'),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                              icon: const Icon(Icons.edit, color: Colors.white, size: 25),
                              color: Colors.black,
                              onPressed: () async {
                                final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                setState(() {
                                  if (pickedFile != null) {
                                    _image = File(pickedFile.path);
                                  } else {
                                    print('No image selected.');
                                  }
                                });
                              },
                            ),
                            )
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(controller: _nameController, label: 'Name', isEditable: true),
                      const SizedBox(height: 20),
                      _buildTextField(controller: _emailController, label: 'Email', isEditable: false), // Read-only
                      const SizedBox(height: 20),
                      _buildTextField(controller: _phoneController, label: 'Phone', isEditable: true, keyboardType: TextInputType.phone),
                      const SizedBox(height: 20),
                      _buildTextField(controller: _nationalIdController, label: 'CCCD/CMND', isEditable: true, keyboardType: TextInputType.number),
                      const SizedBox(height: 20),
                      _buildTextField(controller: _genderController, label: 'Gender', isEditable: true),
                      const SizedBox(height: 20),
                      _buildTextField(controller: _addressController, label: 'Address', isEditable: true),
                      const SizedBox(height: 30),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _updateProfile();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please fill out all fields correctly.')),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white, // Button color
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                            textStyle: const TextStyle(fontSize: 18),
                          ),
                          child: const Text('Save Changes'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required bool isEditable,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      enabled: isEditable,
      readOnly: !isEditable,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) {
        if (isEditable && (value == null || value.isEmpty)) {
          return 'Please enter your $label';
        }
        return null;
      },
    );
  }
}
