class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? gender;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'gender': gender,
    };
  }
}