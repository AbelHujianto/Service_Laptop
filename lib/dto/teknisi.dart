class TeknisiData {
  String deskripsi;
  int idKonsultasi;
  int idRequest;
  int idTeknisi;
  int idUser;
  String judul;

  TeknisiData({
    required this.deskripsi,
    required this.idKonsultasi,
    required this.idRequest,
    required this.idTeknisi,
    required this.idUser,
    required this.judul,
  });

  factory TeknisiData.fromJson(Map<String, dynamic> json) {
    return TeknisiData(
      deskripsi: json['deskripsi'],
      idKonsultasi: json['id_konsultasi'],
      idRequest: json['id_request'],
      idTeknisi: json['id_teknisi'],
      idUser: json['id_user'],
      judul: json['judul'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deskripsi': deskripsi,
      'id_konsultasi': idKonsultasi,
      'id_request': idRequest,
      'id_user': idUser,
      'judul': judul,
    };
  }
}
