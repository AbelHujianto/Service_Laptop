// ignore: file_names

import 'dart:convert';

Api apiFromJson(String str) => Api.fromJson(json.decode(str));

String apiToJson(Api data) => json.encode(data.toJson());

class Api {
    List<Data> datas;
    String message;

    Api({
        required this.datas,
        required this.message,
    });

    factory Api.fromJson(Map<String, dynamic> json) => Api(
        datas: List<Data>.from(json["datas"].map((x) => Data.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "datas": List<dynamic>.from(datas.map((x) => x.toJson())),
        "message": message,
    };
}

class Data {
    String brand;
    String deskripsi;
    int idRequest;
    int idUser;
    String judul;
    String model;
    String serialNumber;
    String tanggalService;
    String status;

    Data({
        required this.brand,
        required this.deskripsi,
        required this.idRequest,
        required this.idUser,
        required this.judul,
        required this.model,
        required this.serialNumber,
        required this.tanggalService,
        required this.status,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        brand: json["brand"],
        deskripsi: json["deskripsi"],
        idRequest: json["id_request"],
        idUser: json["id_user"],
        judul: json["judul"],
        model: json["model"],
        serialNumber: json["serial_number"],
        tanggalService: json["tanggal_service"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "brand": brand,
        "deskripsi": deskripsi,
        "id_request": idRequest,
        "id_user": idUser,
        "judul": judul,
        "model": model,
        "serial_number": serialNumber,
        "tanggal_service": tanggalService,
        "status": status,
        
    };
}