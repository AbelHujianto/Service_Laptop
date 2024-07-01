
import 'package:flutter/material.dart';
import 'package:my_app/servis/dataservis.dart';

class InputApi extends StatefulWidget {
  const InputApi({Key? key}) : super(key: key);

  @override
  State<InputApi> createState() => _InputApiState();
}

class _InputApiState extends State<InputApi> {
  final _simpanDataTitle = TextEditingController();
  final _simpanDataBody = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
        backgroundColor: const Color.fromARGB(255, 169, 150, 212),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: _simpanDataTitle,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Masukkan title',
              hintText: 'Title',
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: _simpanDataBody,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Masukkan body',
              hintText: 'Body',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                DataService.postEvent(
                  _simpanDataTitle.text,
                  _simpanDataBody.text,
                );
                Navigator.of(context).pop();
              });
            },
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}

