// ignore: file_names
import 'package:flutter/material.dart';
import 'package:my_app/dto/service_request.dart';
import 'package:my_app/servis/dataservis.dart';

class UpdateServ extends StatelessWidget {
  final Data object;

  const UpdateServ({Key? key, required this.object}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController idRequestController = TextEditingController(text: object.idRequest.toString());
    final TextEditingController brandController = TextEditingController(text: object.brand);
    final TextEditingController modelController = TextEditingController(text: object.model);
    final TextEditingController serialNumberController = TextEditingController(text: object.serialNumber);
    final TextEditingController deskripsiController = TextEditingController(text: object.deskripsi);
    final TextEditingController judulController = TextEditingController(text: object.judul);
    final TextEditingController idUserController = TextEditingController(text: object.idUser.toString());
    final TextEditingController tanggalServiceController = TextEditingController(text: object.tanggalService);
    String status = object.status;

    return Scaffold(
      appBar: AppBar(title: const Text('Perbarui Permintaan Layanan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: idRequestController,
                decoration: const InputDecoration(labelText: 'ID Request'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: judulController,
                decoration: const InputDecoration(labelText: 'Judul'),
              ),
              TextField(
                controller: deskripsiController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
              ),
              TextField(
                controller: brandController,
                decoration: const InputDecoration(labelText: 'Brand'),
              ),
              TextField(
                controller: modelController,
                decoration: const InputDecoration(labelText: 'Model'),
              ),
              TextField(
                controller: serialNumberController,
                decoration: const InputDecoration(labelText: 'Serial Number'),
              ),
              TextField(
                controller: idUserController,
                decoration: const InputDecoration(labelText: 'ID User'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: tanggalServiceController,
                decoration: const InputDecoration(labelText: 'Tanggal Service'),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    tanggalServiceController.text = pickedDate.toIso8601String().split('T').first;
                  }
                },
              ),
              DropdownButton<String>(
                value: status,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    status = newValue;
                  }
                },
                items: <String>['belum diservice', 'diproses', 'selesai']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final updatedData = Data(
                      idRequest: int.parse(idRequestController.text),
                      idUser: int.parse(idUserController.text),
                      brand: brandController.text,
                      model: modelController.text,
                      serialNumber: serialNumberController.text,
                      deskripsi: deskripsiController.text,
                      judul: judulController.text,
                      tanggalService: tanggalServiceController.text,
                      status: status,
                    );
                    await DataService.updateServiceRequest(updatedData);
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  } catch (e) {
                    showDialog(
                      // ignore: use_build_context_synchronously
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: Text('Gagal memperbarui permintaan layanan: $e'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text('Perbarui'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}