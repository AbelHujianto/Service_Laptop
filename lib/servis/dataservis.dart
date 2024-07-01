import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/dto/cust.dart';
import 'package:my_app/dto/datas.dart';
import 'package:my_app/dto/register.dart';
import 'dart:convert';

//import 'package:my_app/dto/news.dart';
import 'package:my_app/dto/spendings.dart';
import 'package:my_app/dto/balances.dart';
import 'package:my_app/dto/service_request.dart';
import 'package:my_app/dto/consultation.dart';
import 'package:my_app/dto/teknisi.dart';
import 'package:my_app/dto/data_login.dart';
import 'package:my_app/endpoint/endpoint.dart';
import 'package:my_app/utils/constants.dart';
import 'package:my_app/utils/secure_storage_util.dart';

class DataService {
  static Future<List<Data>> fetchServiceRequests() async {
    final response = await http.get(Uri.parse(Endpoint.serviceRequestread));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> data = jsonResponse['datas'];
      return data.map((item) => Data.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load service requests');
    }
  }
  
  static Future<List<Data>> fetchServiceRequestsbyID(int idUser) async {
  final response = await http.get(Uri.parse('${Endpoint.serviceRequestreadbyID}?id_user=$idUser'));

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    final List<dynamic> data = jsonResponse['datas'];
    return data.map((item) => Data.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load service requests');
  }
}


  static Future<List<Datas>> fetchDatas() async {
    final response = await http.get(Uri.parse(Endpoint.datas));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) => Datas.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Failed to load datas');
    }
  }

  static Future<void> deleteDatas(int id) async {
    final url = Uri.parse('${Endpoint.datas}/$id');
    final response = await http.delete(url);
    if (response.statusCode != 200) {
      throw Exception('Failed to delete data');
    }
  }
   static Future<List<CustServ>> fetchCustServ() async {
    final response = await http.get(Uri.parse(Endpoint.nimData));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) => CustServ.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Failed to load datas');
    }
  }

  static Future<void> deleteCustServ(int id) async {
    final url = Uri.parse('${Endpoint.nimData}/$id');
    final response = await http.delete(url);
    if (response.statusCode != 200) {
      throw Exception('Failed to delete data');
    }
  }

  static Future<List<TeknisiData>> fetchTeknisiData() async {
    final response = await http.get(Uri.parse(Endpoint.teknisiread));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> data = jsonResponse['datas'];
      return data.map((item) => TeknisiData.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load teknisi data');
    }
  }

    static Future<List<TeknisiData>> fetchTeknisiDataByIdUser(int idUser) async {
    final response = await http.get(Uri.parse('${Endpoint.teknisireadbyID}?id_user=$idUser'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> data = jsonResponse['datas'];
      return data.map((item) => TeknisiData.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load teknisi data');
    }
  }

  

static Future<void> createTeknisiData(
  String idKonsultasi,
  String idUser,
  String idRequest,
  String judul,
  String deskripsi
) async {
  final url = Uri.parse(Endpoint.teknisicreate);
  Map<String, dynamic> teknisiData = {
    "id_konsultasi": idKonsultasi,
    "id_user": idUser,
    "id_request": idRequest,
    "judul": judul,
    "deskripsi": deskripsi
  };

  String jsonData = jsonEncode(teknisiData);
  
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonData,
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    print("Data teknisi berhasil dikirim");
  } else {
    print("Gagal mengirim data teknisi: ${response.statusCode}");
    print("Response body: ${response.body}");
    throw Exception('Failed to create teknisi data');
  }
}

  static Future<void> sendConsultationRequest(
    String requestId,
    String userId,
    String title,
    String description
  ) async {
    Map<String, dynamic> consultationData = {
      "id_request": requestId,
      "id_user": userId,
      "judul": title,
      "deskripsi": description
    };
    String jsonData = jsonEncode(consultationData);
    final response = await http.post(
      Uri.parse(Endpoint.consultationcreate),
      body: jsonData,
      headers: {'Content-Type': 'application/json'},
    );
  
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Data berhasil dikirim");
    } else {
      print("Gagal mengirim data: ${response.statusCode}");
      print("Response body: ${response.body}");
    }
  }
  static Future<void> deleteServiceRequest(int id) async {
  final url = Uri.parse('${Endpoint.serviceRequestdelete}/$id');
  print('Sending DELETE request to: $url');
  final response = await http.delete(url, headers: {'Content-Type': 'application/json'});
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  if (response.statusCode != 200) {
    throw Exception('Failed to delete service request');
  }
}

  static Future<void> updateServiceRequest(Data data) async {
    final url = Uri.parse('${Endpoint.serviceRequestupdate}/${data.idRequest}');
    final jsonData = jsonEncode(data.toJson());

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );

      if (response.statusCode == 200) {
        print('Permintaan layanan berhasil diperbarui');
      } else {
        print('Gagal memperbarui permintaan layanan. Kode status: ${response.statusCode}');
        print('Isi tanggapan: ${response.body}');
        throw Exception('Gagal memperbarui permintaan layanan');
      }
    } on http.ClientException catch (e) {
      print('ClientException: ${e.message}');
      throw Exception('ClientException: ${e.message}');
    } catch (e) {
      print('Kesalahan tak terduga: $e');
      throw Exception('Kesalahan tak terduga: $e');
    }
  }


static Future<void> sendServiceRequest(int idUser, String tanggalService, String judul, String deskripsi, String serialnumber, String brand, String model,String status) async {
  Map<String, dynamic> serviceData = {
    "id_user": idUser,
    "tanggal_service": tanggalService,
    "judul": judul,
    "deskripsi": deskripsi,
    "serial_number": serialnumber,
    "brand": brand,
    "model": model,
    "status": status,
  };
  String jsonData = jsonEncode(serviceData);
  final response = await http.post(
    Uri.parse(Endpoint.serviceRequestcreate),
    body: jsonData,
    headers: {'Content-Type': 'application/json'},
  );
  
  if (response.statusCode == 200 || response.statusCode == 201) {
    print("Data berhasil dikirim");
  } else {
    print("Gagal mengirim data: ${response.statusCode}");
    print("Response body: ${response.body}");
  }
}

static Future<List<ConsultationData>> fetchConsultationData() async {
    final response = await http.get(Uri.parse(Endpoint.consultationread)); // Sesuaikan dengan endpoint ConsultationData
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) => ConsultationData.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load consultation data');
    }
  }

  
//get balance
  static Future<List<Balances>> fetchBalances() async{
    final response = await http.get(Uri.parse(Endpoint.balance));
    if (response.statusCode == 200) {
       final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
        .map((item) => Balances.fromJson(item as Map<String, dynamic>))
        .toList();
    } else {
      // Handle error
      throw Exception('Failed to load data');
    }
  }

  //get spending
  static Future<List<Spendings>> fetchSpendings() async{
    final response = await http.get(Uri.parse(Endpoint.spending));
    if (response.statusCode == 200) {
       final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
        .map((item) => Spendings.fromJson(item as Map<String, dynamic>))
        .toList();
    } else {
      // Handle error
      throw Exception('Failed to load data');
    }
  }

  //post spending
  static Future<http.Response> sendSpendingData(int spending) async{
    final url = Uri.parse(Endpoint.spending);
    final data = {'spending': spending};

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return response;
  }

  static void postEvent(String text, String text2) {}




//post login with email and password
  static Future<http.Response> sendLoginData(String username, String password) async {
    final url = Uri.parse(Endpoint.datalogin);
    final data = {'username': username, 'password': password};

    try {
      final response = await http.post(
        url,
        body: data,
      );
      return response;
    } catch (e) {
      debugPrint("Error during http.post: $e");
      return http.Response('Error', 500);
    }
  }
static Future<DataLogin> fetchProfile(String? accessToken) async {
    accessToken ??= await SecureStorageUtil.storage.read(key: tokenStoreName);

    final response = await http.get(
      Uri.parse(Endpoint.login),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    debugPrint('Profile response: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse;
      try {
        jsonResponse = jsonDecode(response.body);
      } catch (e) {
        throw Exception('Failed to parse JSON: $e');
      }

      try {
        return DataLogin.fromJson(jsonResponse);
      } catch (e) {
        throw Exception('Failed to parse Profile: $e');
      }
    } else {
      throw Exception(
          'Failed to load Profile with status code: ${response.statusCode}');
    }
  }

    static Future<http.Response> sendRegisterData(Register register) async {
    final url = Uri.parse(Endpoint.register);
    final data = register.toJson();

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      return response;
    } catch (e) {
      print("Error during http.post: $e");
      return http.Response('Error', 500);
    }
  }

  static Future<http.Response> logoutData() async {
    final url = Uri.parse(Endpoint.logout);
    final String? accessToken = await SecureStorageUtil.storage.read(key: tokenStoreName);
    debugPrint("Logout with $accessToken");

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    return response;
    }
}