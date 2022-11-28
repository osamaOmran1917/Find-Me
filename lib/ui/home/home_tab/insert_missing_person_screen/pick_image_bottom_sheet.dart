import 'dart:io';

import 'package:find_me_ii/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class PickImageBottomSheet extends StatefulWidget {
  @override
  State<PickImageBottomSheet> createState() => _PickImageBottomSheetState();
}

class _PickImageBottomSheetState extends State<PickImageBottomSheet> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color: MyTheme.primaryColor,
      ),
      height: MediaQuery.of(context).size.height * .17,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: captureImage,
            child: Image.asset(
              'assets/images/camera.png',
              width: 50,
              height: 50,
            ),
          ),
          InkWell(
            onTap: () => _pickImage(ImageSource.gallery),
            child: _image == null
                ? Image.asset(
                    'assets/images/picture.png',
                    width: 50,
                    height: 50,
                  )
                : PickImageBottomSheet(),
          ),
        ],
      ),
    );
  }

  void captureImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image as File?;
    });
  }

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      setState(() {
        _image = img;
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }
}