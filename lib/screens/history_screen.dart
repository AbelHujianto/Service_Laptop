import 'package:flutter/material.dart';
import 'package:my_app/servis/dataservis.dart';
import 'package:my_app/dto/service_request.dart'; // Import your models
import 'package:my_app/screens/UpdateServ.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key, required String selectedLocation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Aktivitas Service Laptop'),
        ),
        body: const ServiceListView(),
      ),
    );
  }
}

class ServiceListView extends StatefulWidget {
  const ServiceListView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ServiceListViewState createState() => _ServiceListViewState();
}

class _ServiceListViewState extends State<ServiceListView> {
  late Future<List<Data>> futureServiceRequests;

  @override
  void initState() {
    super.initState();
    futureServiceRequests = DataService.fetchServiceRequests();
  }

  Future<void> _confirmAndDelete(Data item) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Apakah Anda yakin ingin menghapus data ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Tidak'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Ya'),
          ),
        ],
      ),
    );
    if (confirmed) {
      await DataService.deleteServiceRequest(item.idRequest);
      setState(() {
        futureServiceRequests = DataService.fetchServiceRequests();
      });
    }
  }

  Future<void> _navigateToUpdate(Data item) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateServ(object: item),
      ),
    );
    setState(() {
      futureServiceRequests = DataService.fetchServiceRequests();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Data>>(
      future: futureServiceRequests,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.hourglass_empty, size: 100),
                SizedBox(height: 20),
                Text('Belum ada aktivitas service laptop', style: TextStyle(fontSize: 20)),
              ],
            ),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final item = snapshot.data![index];
              return ListTile(
                title: Text(item.judul),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.deskripsi),
                    Text('Brand: ${item.brand}'),
                    Text('Model: ${item.model}'),
                    Text('Serial Number: ${item.serialNumber}'),
                    Text('Tanggal Service: ${item.tanggalService}'),
                    Text('Status: ${item.status}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            _confirmAndDelete(item);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                        IconButton(
                          onPressed: () {
                            _navigateToUpdate(item);
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
