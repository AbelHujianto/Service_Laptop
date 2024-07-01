import 'package:flutter/material.dart';
import 'package:my_app/servis/dataservis.dart';

class CreateTeknisiScreen extends StatelessWidget {
  final TextEditingController idKonsultasiController = TextEditingController();
  final TextEditingController idUserController = TextEditingController();
  final TextEditingController idRequestController = TextEditingController();
  final TextEditingController judulController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  CreateTeknisiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Teknisi Baru'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              TextField(
                controller: idKonsultasiController,
                decoration: const InputDecoration(labelText: 'ID Konsultasi'),
              ),
              TextField(
                controller: idUserController,
                decoration: const InputDecoration(labelText: 'ID User'),
              ),
              TextField(
                controller: idRequestController,
                decoration: const InputDecoration(labelText: 'ID Request'),
              ),
              TextField(
                controller: judulController,
                decoration: const InputDecoration(labelText: 'Judul'),
              ),
              TextField(
                controller: deskripsiController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await DataService.createTeknisiData(
                      idKonsultasiController.text,
                      idUserController.text,
                      idRequestController.text,
                      judulController.text,
                      deskripsiController.text,
                    );
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  } catch (e) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Gagal membuat data teknisi: $e')),
                    );
                  }
                },
                child: const Text('Kirim'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
