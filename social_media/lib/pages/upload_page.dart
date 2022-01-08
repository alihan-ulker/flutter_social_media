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
    return const Center(
      child: Text("Yüklenen resim ve text alanları gelecek."),
    );
  }

  pickPhoto() {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("Gönderi Oluştur"),
          children: [
            SimpleDialogOption(
              child: Text("Fotoğraf Çek"),
              onPressed: () {
                takePhoto();
              },
            ),
            SimpleDialogOption(
              child: Text("Galeriden Yükle"),
              onPressed: () {
                pickFromGallery();
              },
            ),
            SimpleDialogOption(
              child: Text("İptal"),
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
