//@dart=2.9
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File file;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return file == null ? uploadButton() : postForm();
  }

  Widget uploadButton() {
    return IconButton(
        onPressed: () {
          pickPhoto();
        },
        icon: const Icon(
          Icons.file_upload,
          size: 50.0,
          //color: Colors.black,
        ));
  }

  Widget postForm() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: const Text(
          "Gönderi Oluştur",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              setState(() {
                file = null;
              });
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: ListView(
        children: [
          loading
              ? const LinearProgressIndicator()
              : const SizedBox(
                  height: 0.0,
                ),
          AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: Image.file(
              file,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  pickPhoto() {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Gönderi Oluştur"),
          children: [
            SimpleDialogOption(
              child: const Text("Fotoğraf Çek"),
              onPressed: () {
                takePhoto();
              },
            ),
            SimpleDialogOption(
              child: const Text("Galeriden Yükle"),
              onPressed: () {
                pickFromGallery();
              },
            ),
            SimpleDialogOption(
              child: const Text("İptal"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  takePhoto() async {
    Navigator.pop(context);
    var image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 800,
      maxHeight: 600,
      imageQuality: 80,
    );
    setState(() {
      file = File(image.path);
    });
  }

  pickFromGallery() async {
    Navigator.pop(context);
    var image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 600,
      imageQuality: 80,
    );
    setState(() {
      file = File(image.path);
    });
  }
}
