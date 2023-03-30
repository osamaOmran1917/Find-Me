import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_me_ii/data_base/missing_person.dart';
import 'package:find_me_ii/data_base/my_database.dart';
import 'package:find_me_ii/helpers/dialog_utils.dart';
import 'package:find_me_ii/helpers/my_theme.dart';
import 'package:find_me_ii/ui/providers/settings_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditMissingPersonScreen extends StatefulWidget {
  EditMissingPersonScreen({required this.missingPerson});

  MissingPerson missingPerson;

  @override
  State<EditMissingPersonScreen> createState() =>
      _EditMissingPersonScreenState();
}

class _EditMissingPersonScreenState extends State<EditMissingPersonScreen> {
  var formKey = GlobalKey<FormState>();
  String? _image;
  bool b1 = false, b2 = false, b3 = false, b4 = false;

  @override
  Widget build(BuildContext context) {
    String? newName = widget.missingPerson.name;
    String? newAddress = widget.missingPerson.adress;
    String? newDesc = widget.missingPerson.desc;
    String? newAge = widget.missingPerson.age;
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              widget.missingPerson.name ??
                  AppLocalizations.of(context)!.nameNotAvailable,
              style: TextStyle(color: MyTheme.basicWhite)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    onSaved: (val) => newName = val,
                    initialValue: widget.missingPerson.name,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        b1 = true;
                        return null;
                      } else {
                        b1 = false;
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        prefixIcon: Icon(
                          CupertinoIcons.person_alt,
                          color: Colors.blue,
                        ),
                        hintText: AppLocalizations.of(context)!.egAhmedAdam,
                        label: Text(AppLocalizations.of(context)!.name)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                  ),
                  TextFormField(
                    initialValue: widget.missingPerson.adress,
                    onSaved: (val) => newAddress = val,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        b2 = true;
                        return null;
                      } else {
                        b2 = false;
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        prefixIcon: Icon(
                          CupertinoIcons.location_solid,
                          color: Colors.blue,
                        ),
                        hintText: 'eg. Ruxi-Cairo-Egypt',
                        label: Text(
                            AppLocalizations.of(context)!.detailedAddress)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    initialValue: widget.missingPerson.desc,
                    onSaved: (val) => newDesc = val,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        b3 = true;
                        return null;
                      } else {
                        b3 = false;
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        prefixIcon: ImageIcon(
                          AssetImage('assets/images/description.png'),
                          color: Colors.blue,
                        ),
                        hintText:
                            'eg. Tall gross boy with a stubble and dark skin',
                        label: Text('Description')),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: widget.missingPerson.age,
                    onSaved: (val) => newAge = val,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        b4 = true;
                        return null;
                      } else {
                        b4 = false;
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        prefixIcon: ImageIcon(
                          AssetImage('assets/images/age.png'),
                          color: Colors.blue,
                        ),
                        hintText: 'eg. 15',
                        label: Text(AppLocalizations.of(context)!.age)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .1,
                  ),
                  ElevatedButton(
                    child: Text(
                      'save changes',
                      style: TextStyle(color: MyTheme.basicWhite),
                    ),
                    onPressed: () {
                      if (formKey.currentState?.validate() == true) {
                        if (b1 && b2 && b3 && b4) {
                          showMessage(
                              context,
                              AppLocalizations.of(context)!
                                  .pleaseFillInAtLeastOneStatement);
                          return;
                        } else {
                          formKey.currentState!.save();
                          MyDataBase.updateAllMissingPersonInfo(
                                  missingPerson: widget.missingPerson,
                                  name: newName,
                                  address: newAddress,
                                  desc: newDesc,
                                  age: newAge)
                              .then((value) {
                            Dialogs.showSnackbar(
                                context, 'Info Updated Successfully');
                            Navigator.pop(context);
                          });
                        }
                      } else
                        return;
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: MyTheme.basicBlue))),
                      backgroundColor: MaterialStateProperty.all(
                          settingsProvider.isDarkMode()
                              ? MyTheme.coloredSecondary
                              : MyTheme.basicBlack),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .1,
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
                                imageUrl: widget.missingPerson.image ?? '',
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
                AppLocalizations.of(context)!.pickAPicture,
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
                          MyDataBase.updateMissingPersonPicture(
                              File(_image!), widget.missingPerson);
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
                          MyDataBase.updateMissingPersonPicture(
                              File(_image!), widget.missingPerson);
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
