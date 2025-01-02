class User {
  final String id;
  final String name;
  final String email; 
  final String password; 
  final String? vToken;
  final String image; 
  final String? nationalid;
  final String role; 
  final String address;
  final String gender;
  final String phone; 
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.vToken,
    required this.image,
    this.nationalid,
    required this.role,
    required this.address,
    required this.gender,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create a User object from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      vToken: json['token'],
      image: json['image'] ?? '',
      nationalid: json['nationalid'],
      role: json['role'] ?? '',
      address: json['address'] ?? '',
      gender: json['gender'] ?? '',
      phone: json['phone'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  // Method to convert User object to JSON
  Map<String, dynamic> toJson() => {
    "name": name,
    "role": role,
    "address": address,
    "gender": gender,
    "phone": phone,
    "nationalid" : nationalid,

  };
}
