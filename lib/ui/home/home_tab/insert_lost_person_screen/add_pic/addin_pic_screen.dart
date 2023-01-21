import 'dart:io';

import 'package:find_me_ii/data_base/missing_person.dart';
import 'package:find_me_ii/my_theme.dart';
import 'package:find_me_ii/ui/home/home_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'add_pic_viewModel.dart';

class AddPic extends StatefulWidget {
  static const String routeName = 'Add Pic';

  static MissingPerson? missingPerson;

  File? img;

  @override
  State<AddPic> createState() => _AddPicState();
}

class _AddPicState extends State<AddPic> implements AddPicNavigator {
  late AddPicViewModel viewModel;

  final ImagePicker _picker = ImagePicker();
  File? _image;

  @override
  void initState() {
    super.initState();
    viewModel = AddPicViewModel();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Scaffold(
        body: Center(
          child: FadeInRight(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width * .9,
              height: MediaQuery.of(context).size.height * .9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: MyTheme.coloredSecondary.withOpacity(.25)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'You\'ve just added a lost person.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  _image == null
                      ? Container()
                      : Image.file(
                          _image!,
                          fit: BoxFit.fill,
                          height: MediaQuery.of(context).size.width * .65,
                        ),
                  Container(
                    height: MediaQuery.of(context).size.height * .25,
                    decoration: BoxDecoration(
                        color: MyTheme.basicWhite,
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(_image == null
                            ? 'Add pic to this person'
                            : 'Change pic'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () => captureImage(),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/camera.png',
                                    width:
                                        MediaQuery.of(context).size.width * .12,
                                    height: MediaQuery.of(context).size.height *
                                        .12,
                                  ),
                                  Text('capture')
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => _pickImage(ImageSource.gallery),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/picture.png',
                                    width:
                                        MediaQuery.of(context).size.width * .12,
                                    height: MediaQuery.of(context).size.height *
                                        .12,
                                  ),
                                  Text('select')
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _image == null ? false : true,
                    child: ElevatedButton(
                        onPressed: () async {
                          final _firebaseStorage = FirebaseStorage.instance;
                          var file = File(_image!.path);
                          if (_image != null) {
                            //Upload to Firebase
                            var snapshot = await _firebaseStorage
                                .ref()
                                .child('images/${AddPic.missingPerson?.name}')
                                .putFile(file)
                                .whenComplete(() => null);
                            var downloadUrl =
                                await snapshot.ref.getDownloadURL();
                          } else {
                            print('No Image Path Received');
                          }
                          viewModel.onSkipPrsd();
                        },
                        child: Text('Save Pic')),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        viewModel.onSkipPrsd();
                      },
                      child: Text('Skip'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void goToNewsFeed() {
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
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
