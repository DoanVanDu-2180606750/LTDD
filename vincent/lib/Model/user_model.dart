class User {

    final String? name;
    final String email;   
    final String? gender;    
    final String? phone; 
    final String? image;  
    final bool isVacation;
    final String toKen;

    User({
        required this.name,
        required this.email,
        required this.gender,
        required this.image,
        required this.phone,
        required this.isVacation,
        required this.toKen,
    });

    factory User.fromJson(Map<String, dynamic> json){ 
        return User(
            name: json["Name"],
            email: json["Email"],
            gender: json["Gender"],
            image: json["Image"],
            phone: json["Phone"],
            isVacation: json["isVacation"],
            toKen: json["toKen"],
        );
    }

    Map<String, dynamic> toJson() => {
        "Name": name,
        "Email": email,
        "Gender": gender,
        "Phone": phone,
        "Image": image,
        "isVacation": isVacation,
        "toKen": toKen,
    };
}
