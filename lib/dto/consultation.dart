class ConsultationData {
    String deskripsi;
    int idKonsultasi;
    int idRequest;
    int idUser;
    String judul;

    ConsultationData({
        required this.deskripsi,
        required this.idKonsultasi,
        required this.idRequest,
        required this.idUser,
        required this.judul,
    });

    factory ConsultationData.fromJson(Map<String, dynamic> json) => ConsultationData(
        deskripsi: json["deskripsi"],
        idKonsultasi: json["id_konsultasi"],
        idRequest: json["id_request"],
        idUser: json["id_user"],
        judul: json["judul"],
    );

    Map<String, dynamic> toJson() => {
        "deskripsi": deskripsi,
        "id_konsultasi": idKonsultasi,
        "id_request": idRequest,
        "id_user": idUser,
        "judul": judul,
    };
}
