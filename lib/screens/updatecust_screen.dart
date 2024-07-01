import 'dart:io';
import 'package:my_app/dto/cust.dart';
import 'package:my_app/endpoint/endpoint.dart';
import 'package:my_app/screens/cust_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class FormUpdateScreen extends StatefulWidget {
  const FormUpdateScreen({Key? key, required this.object}) : super(key: key);

  final CustServ object;

  @override
  State<FormUpdateScreen> createState() => _UpdateCustState();
}

class _UpdateCustState extends State<FormUpdateScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _nimController = TextEditingController();
  int _rating = 0; 

  File? galleryFile;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.object.title;
    _descriptionController.text = widget.object.deskripsi;
    _nimController.text = widget.object.nim;
  }

  _showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(
    ImageSource img,
  ) async {
    final pickedFile = await picker.pickImage(source: img);
    setState(
      () {
        if (pickedFile != null) {
          galleryFile = File(pickedFile.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Nothing is selected')),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _nimController.dispose();
    super.dispose();
  }

  saveData() {
    debugPrint(_titleController.text);
    debugPrint(_descriptionController.text);
    debugPrint(_nimController.text);
    debugPrint(_rating.toString());
  }

  Future<void> _editDataWithImage(BuildContext context) async {
    if (galleryFile == null) {
      return; // Handle case where no image is selected
    }

    var request = MultipartRequest('POST', Uri.parse('${Endpoint.nimData}/${widget.object.idCust}'));
    request.fields['title_issues'] = _titleController.text; // Add other data fields
    request.fields['description_issues'] = _descriptionController.text;
    request.fields['nim'] = _nimController.text;
    request.fields['rating'] = _rating.toString();

    var multipartFile = await MultipartFile.fromPath(
      'image',
      galleryFile!.path,
    );
    request.files.add(multipartFile);

    request.send().then((response) {
      // Handle response (success or error)
      if (response.statusCode == 201) {
        debugPrint('Data and image posted successfully!');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CustomerServiceScreen()));
      } else {
        debugPrint('Error posting data: ${response.statusCode}');
      }
    });
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customer Service',
          style: GoogleFonts.poppins(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title Issues',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Deskripsi Issues',
              )
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nimController,
              decoration: const InputDecoration(
                labelText: 'NIM',
              ),
              maxLines: null,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Rating: '),
                Slider(
                  value: _rating.toDouble(),
                  min: 0,
                  max: 5,
                  divisions: 5,
                  onChanged: (value) {
                    setState(() {
                      _rating = value.toInt();
                    });
                  },
                ),
                Text('$_rating'),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    _showPicker(context: context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: 150,
                    child: galleryFile == null
                        ? Center(
                            child: Text(
                              'Pick your Image here',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: const Color.fromARGB(255, 124, 122, 122),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        : Center(
                            child: Image.file(galleryFile!),
                          ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _editDataWithImage(context);
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}