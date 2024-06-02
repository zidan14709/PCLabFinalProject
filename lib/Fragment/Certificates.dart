import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class Certificates extends StatefulWidget {
  const Certificates({Key? key}) : super(key: key);

  @override
  _CertificatesState createState() => _CertificatesState();
}

class _CertificatesState extends State<Certificates> {
  var myItems = [
    "lib/Assets/images/rb.jpg",
    "lib/Assets/images/mn.jpg",
  ];

  void addCertificate(String path) {
    setState(() {
      myItems.add(path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Certificates"),
        backgroundColor: const Color.fromARGB(255, 110, 0, 150),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: myItems.length,
                itemBuilder: (context, index) {
                  return CertificateImage(imagePath: myItems[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles();

                  if (result != null) {
                    PlatformFile file = result.files.first;
                    addCertificate(file.path!);
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 150, 137, 0), // Text color
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text("Upload"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CertificateImage extends StatelessWidget {
  final String imagePath;

  const CertificateImage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
