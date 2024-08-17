import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:puppycode/shared/app_bar.dart';
import 'package:puppycode/shared/styles/color.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  XFile? _image;
  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.black,
      appBar: SharedAppBar(
        leftOptions: AppBarLeft(
          iconType: LeftIconType.BACK,
          iconColor: ThemeColor.white,
        ),
        centerOptions: AppBarCenter(
          label: '앨범',
          labelColor: ThemeColor.white,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30, width: double.infinity),
          _buildPhotoArea(),
          const SizedBox(height: 20),
          _buildButton(),
        ],
      ),
    );
  }

  Widget _buildPhotoArea() {
    return _image != null
        ? SizedBox(
            width: 300,
            height: 300,
            child: Image.file(File(_image!.path)), //가져온 이미지를 화면에 띄워주는 코드
          )
        : Container(
            width: 300,
            height: 300,
            color: Colors.grey,
          );
  }

  Widget _buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 30),
        ElevatedButton(
          onPressed: () {
            getImage(ImageSource.gallery); //getImage 함수를 호출해서 갤러리에서 사진 가져오기
          },
          child: const Text("갤러리"),
        ),
      ],
    );
  }
}
