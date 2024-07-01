import 'package:flutter/material.dart';
import 'package:my_app/screens/CreateTeknisiScreen.dart';
import 'package:my_app/servis/dataservis.dart';
import 'package:my_app/dto/consultation.dart' as consultation_dto;

class HomeTeknisiScreen extends StatefulWidget {
  const HomeTeknisiScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeTeknisiScreenState createState() => _HomeTeknisiScreenState();
}

class _HomeTeknisiScreenState extends State<HomeTeknisiScreen> {
  late Future<List<consultation_dto.ConsultationData>> _consultations;

  @override
  void initState() {
    super.initState();
    _consultations = DataService.fetchConsultationData();
  }

  Future<void> _navigateToCreateScreen(BuildContext context) async {
    final newItem = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateTeknisiScreen()),
    );

    if (newItem != null) {
      setState(() {
        _consultations = DataService.fetchConsultationData(); // Refresh data
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Teknisi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Data yang Tersedia',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: FutureBuilder<List<consultation_dto.ConsultationData>>(
                future: _consultations,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No data available'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final item = snapshot.data![index];
                        return Card(
                          child: ListTile(
                            title: Text(item.judul),
                            subtitle: Text(
                              'ID Konsultasi: ${item.idKonsultasi}\n'
                              'ID User: ${item.idUser}\n'
                              'ID Request: ${item.idRequest}\n'
                              'Deskripsi: ${item.deskripsi}',
                            ),
                            leading: const Icon(Icons.description),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToCreateScreen(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
