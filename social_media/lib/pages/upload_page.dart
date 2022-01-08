//@dart=2.9
import 'dart:io';
import 'package:flutter/material.dart';

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
        onPressed: () {},
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
}
