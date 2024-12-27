class User {
  final String? name;
  final int? price;
  final double? star;
  final String? describe;
  final bool? status;
  final String? bed;
  final int? capacity;
  final String? image1;
  final String? image2;
  final String? image3;
  final String? image4;
  final String? image5;  
  final String? roomType;   
  final List<String> amenities;
  final String? location;
  final List<dynamic> reviews;
  final DateTime? updatedAt;
  final String? discount;
  User({
    required this.name,
    required this.price,
    required this.star,
    required this.describe,
    required this.status,
    required this.bed,
    required this.capacity,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
    required this.image5,
    required this.roomType,
    required this.amenities,
    required this.location,
    required this.reviews,
    required this.updatedAt,
    required this.discount,
  });
    
  User copyWith({
    String? name,
    int? price,
    double? star,
    String? describe,
    bool? status,
    String? bed,
    int? capacity,
    String? image1,
    String? image2,
    String? image3,
    String? image4,
    String? image5,
    String? roomType,
    List<String>? amenities,
    String? location,
    List<dynamic>? reviews,
    DateTime? updatedAt,
    String? discount,
  }) {
    return User(
      name: name ?? this.name,
      price: price ?? this.price,
      star: star ?? this.star,
      describe: describe ?? this.describe,
      status: status ?? this.status,
      bed: bed ?? this.bed,
      capacity: capacity ?? this.capacity,
      image1: image1 ?? this.image1,
      image2: image2 ?? this.image2,
      image3: image3 ?? this.image3,
      image4: image4 ?? this.image4,
      image5: image5 ?? this.image5,
      roomType: roomType ?? this.roomType,
      amenities: amenities ?? this.amenities,
      location: location ?? this.location,
      reviews: reviews ?? this.reviews,
      updatedAt: updatedAt ?? this.updatedAt,
      discount: discount ?? this.discount,
    );
  }

  factory User.fromJson(Map<String, dynamic> json){ 
    return User(
      name: json["name"],
      price: json["price"],
      star: json["star"],
      describe: json["describe"],
      status: json["status"],
      bed: json["bed"],
      capacity: json["capacity"],
      image1: json["image1"],
      image2: json["image2"],
      image3: json["image3"],
      image4: json["image4"],
      image5: json["image5"],
      roomType: json["room_type"],
      amenities: json["amenities"] == null ? [] : List<String>.from(json["amenities"]!.map((x) => x)),
      location: json["location"],
      reviews: json["reviews"] == null ? [] : List<dynamic>.from(json["reviews"]!.map((x) => x)),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      discount: json["discount"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "star": star,
    "describe": describe,
    "status": status,
    "bed": bed,
    "capacity": capacity,
    "image1": image1,
    "image2": image2,
    "image3": image3,
    "image4": image4,
    "image5": image5,
    "room_type": roomType,
    "amenities": amenities.map((x) => x).toList(),
    "location": location,
    "reviews": reviews.map((x) => x).toList(),
    "updated_at": updatedAt?.toIso8601String(),
    "discount": discount,
  };
}
