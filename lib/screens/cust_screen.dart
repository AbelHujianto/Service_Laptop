import 'package:my_app/components/bottom_up.dart';
import 'package:my_app/dto/cust.dart';
import 'package:my_app/endpoint/endpoint.dart';
import 'package:my_app/screens/updatecust_screen.dart';
import 'package:my_app/screens/formcust_screen.dart';
import 'package:my_app/servis/dataservis.dart';
import 'package:flutter/material.dart';

class CustomerServiceScreen extends StatefulWidget {
  const CustomerServiceScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomerServiceScreen createState() => _CustomerServiceScreen();
}

class _CustomerServiceScreen extends State<CustomerServiceScreen> {
  Future<List<CustServ>>? _custServs;

  @override
  void initState() {
    super.initState();
    _custServs = DataService.fetchCustServ(); // Menggunakan fetchCustServs untuk mengambil data CustServ
  }

  Future<void> _confirmAndDelete(CustServ custServ) async {
    final bool confirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Data'),
        content: const Text('Are you sure you want to delete this data?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed) {
      try {
        await DataService.deleteCustServ(custServ
            .idCust); // Menggunakan deleteCustServ untuk menghapus data CustServ
        setState(() {
          _custServs = DataService
              .fetchCustServ(); // Mengambil ulang data setelah penghapusan
        });
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data deleted successfully'),
          ),
        );
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete data: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Service'),
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder<List<CustServ>>(
        future: _custServs,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return ListTile(
                  title: item.imageUrl != null
                      ? Row(
                          children: [
                            Image.network(
                              fit: BoxFit.fitWidth,
                              width: 350,
                              Uri.parse(
                                      '${Endpoint.baseURLLive}/public/${item.imageUrl!}')
                                  .toString(),
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons
                                      .error), // Display error icon if image fails to load
                            ),
                            const SizedBox(width: 10),
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [

                            //   ],
                            // ),
                          ],
                        )
                      : null,
                  subtitle: Column(
                    children: [
                      Text(
                        'title_issues: ${item.title}', // Menampilkan judul
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'nim : ${item.nim}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'description_issues: ${item.deskripsi}', // Menampilkan deskripsi
                        style: const TextStyle(fontSize: 16),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'rating: ${item.rating}', // Menampilkan rating
                            style: const TextStyle(fontSize: 14),
                          ),
                          const Icon(Icons.star, color: Colors.amber),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              _confirmAndDelete(item);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FormUpdateScreen(object: item,),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          const Divider(),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 54, 40, 176),
        tooltip: 'Increment',
        onPressed: () {
          Navigator.push(context, BottomUpRoute(page: const FormCust()));
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}