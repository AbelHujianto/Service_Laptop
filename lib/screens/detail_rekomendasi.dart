import 'package:flutter/material.dart';
import 'package:my_app/servis/dataservis.dart'; // Import DataService

class Detailrekomendasi extends StatefulWidget {
  final String serviceName;

  const Detailrekomendasi({Key? key, required this.serviceName}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DetailrekomendasiState createState() => _DetailrekomendasiState();
}

class _DetailrekomendasiState extends State<Detailrekomendasi> {
  final _formKey = GlobalKey<FormState>();
  final _requestIdController = TextEditingController();
  final _userIdController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.serviceName),
      ),
      backgroundColor: const Color.fromARGB(255, 200, 191, 243),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Masukkan Detail Rekomendasi',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _requestIdController,
                decoration: const InputDecoration(
                  labelText: 'ID Request',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a request ID';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _userIdController,
                decoration: const InputDecoration(
                  labelText: 'ID User',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a user ID';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Judul',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Process form data
                      String requestId = _requestIdController.text;
                      String userId = _userIdController.text;
                      String title = _titleController.text;
                      String description = _descriptionController.text;

                      print('ID Request: $requestId');
                      print('ID User: $userId');
                      print('Judul: $title');
                      print('Deskripsi: $description');

                      await DataService.sendConsultationRequest(
                        requestId,
                        userId,
                        title,
                        description
                      );

                      Navigator.pop(context); // Close the current screen
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _requestIdController.dispose();
    _userIdController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
