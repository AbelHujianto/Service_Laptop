class Register {
  final String username;
  final String password;

  Register({
    required this.username,
    required this.password,
  });

  factory Register.fromJson(Map<String, dynamic> json) => Register(
        username: json['username'],
        password: json['password'],
      );

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}