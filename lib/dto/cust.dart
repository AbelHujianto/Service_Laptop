class CustServ {
  final int idCust;
  final String nim;
  final String title;
  final String deskripsi;
  final int rating;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;


  CustServ({
    required this.idCust,
    required this.nim,
    required this.title,
    required this.deskripsi,
    required this.rating,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,

  });

  factory CustServ.fromJson(Map<String, dynamic> json) {
    return CustServ(
      idCust: json['id_customer_service'] as int,
      nim: json['nim'] as String,
      title: json['title_issues'] as String,
      deskripsi: json['description_issues'] as String,
      rating: json['rating'] as int,
      imageUrl: json['image_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] ),
      updatedAt: DateTime.parse(json['updated_at'] ),
    );
  }
}