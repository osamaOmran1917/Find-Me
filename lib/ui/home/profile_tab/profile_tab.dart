import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_me_ii/data_base/my_database.dart';
import 'package:find_me_ii/dialog_utils.dart';
import 'package:find_me_ii/model/my_user.dart';
import 'package:find_me_ii/shared_data.dart';
import 'package:find_me_ii/ui/log_in/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class ProfileTab extends StatefulWidget {
  final MyUser user;

  const ProfileTab({super.key, required this.user});

  static const String routeName = 'Chat Screen';

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final _formKey = GlobalKey<FormState>();
  String? _image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: FloatingActionButton.extended(
            backgroundColor: Colors.redAccent,
            onPressed: () async {
              showMessage(context,
                  AppLocalizations.of(context)!.areYouSureYouWannaLogout,
                  posAction: () async {
                await FirebaseAuth.instance.signOut().then((value) async {
                  await GoogleSignIn().signOut().then((value) {
                    Navigator.pushReplacementNamed(
                        context, LogInScreen.routeName);
                  });
                });
                SharedData.user = null;
              },
                  posActionName: AppLocalizations.of(context)!.yes,
                  negAction: () {},
                  negActionName: AppLocalizations.of(context)!.no);
            },
            icon: Icon(Icons.logout),
            label: Text(AppLocalizations.of(context)!.logOut),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                  Stack(
                    children: [
                      _image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.height * .1),
                              child: Image.file(
                                File(_image!),
                                width: MediaQuery.of(context).size.height * .2,
                                height: MediaQuery.of(context).size.height * .2,
                                fit: BoxFit.cover,
                                // placeholder: (context, url) => CircularProgressIndicator(),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.height * .1),
                              child: CachedNetworkImage(
                                width: MediaQuery.of(context).size.height * .2,
                                height: MediaQuery.of(context).size.height * .2,
                                fit: BoxFit.cover,
                                imageUrl: widget.user.image ?? '',
                                // placeholder: (context, url) => CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const CircleAvatar(
                                        child: Icon(CupertinoIcons.person_alt)),
                              ),
                            ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: MaterialButton(
                          elevation: 1,
                          onPressed: () {
                            _showBottomSheet();
                          },
                          child: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          color: Colors.white,
                          shape: CircleBorder(),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                  Text(
                    widget.user.userName!,
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                  ),
                  TextFormField(
                    initialValue: widget.user.userName,
                    onSaved: (val) => MyDataBase.me.userName = val ?? '',
                    validator: (val) =>
                        val != null && val.isNotEmpty ? null : 'Required Field',
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        prefixIcon: Icon(
                          CupertinoIcons.person_alt,
                          color: Colors.blue,
                        ),
                        hintText: 'eg. Ahmed Adam',
                        label: Text('Name')),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.numberWithOptions(),
                    maxLength: 11,
                    validator: (val) => val!.length > 0 && val.length < 11
                        ? 'Enter a valid phone number'
                        : null,
                    initialValue: MyDataBase.me.phoneNumber,
                    onSaved: (val) => MyDataBase.me.phoneNumber = val ?? '',
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        prefixIcon: Icon(
                          CupertinoIcons.phone_fill,
                          color: Colors.blue,
                        ),
                        hintText: 'eg. +201234567890',
                        label: Text('Phone Number')),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        MyDataBase.updateUserInfo().then((value) {
                          Dialogs.showSnackbar(
                              context, 'Profile Updated Successfully!');
                        });
                      }
                    },
                    icon: Icon(
                      Icons.edit,
                      size: 25,
                    ),
                    label: Text(
                      'UPDATE',
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        minimumSize: Size(
                            MediaQuery.of(context).size.width * .5,
                            MediaQuery.of(context).size.height * .06)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * .02,
                bottom: MediaQuery.of(context).size.height * .05),
            children: [
              Text(
                'Pick a picture',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: CircleBorder(),
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * .3,
                              MediaQuery.of(context).size.height * .15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 80);
                        if (image != null) {
                          log('Image path: ${image.path} -- MimeType ${image.mimeType}');
                          setState(() {
                            _image = image.path;
                          });
                          MyDataBase.updateProfilePicture(File(_image!));
                          Navigator.pop(context);
                        }
                      },
                      child: Image.asset('assets/images/picture.png')),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: CircleBorder(),
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * .3,
                              MediaQuery.of(context).size.height * .15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.camera, imageQuality: 80);
                        if (image != null) {
                          log('Image path: ${image.path}');
                          setState(() {
                            _image = image.path;
                          });
                          MyDataBase.updateProfilePicture(File(_image!));
                          Navigator.pop(context);
                        }
                      },
                      child: Image.asset('assets/images/camera.png')),
                ],
              )
            ],
          );
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))));
  }
}
