class UserModel {
  final String password;
  final String role;
  final String username;
  final String email;

  UserModel({
    required this.password,
    required this.email,
    required this.username,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      password: json['password'],
      role: json['role'],
      email: json['email'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() => {
        'password': password,
        'role': role,
        'username': username,
        'email': email
      };
}
