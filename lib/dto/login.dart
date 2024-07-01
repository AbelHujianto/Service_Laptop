import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
    String accessToken;
    int expiresIn;
    String type;

    Login({
        required this.accessToken,
        required this.expiresIn,
        required this.type,
    });

    factory Login.fromJson(Map<String, dynamic> json) => Login(
        accessToken: json["access_token"],
        expiresIn: json["expires_in"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "expires_in": expiresIn,
        "type": type,
    };
}