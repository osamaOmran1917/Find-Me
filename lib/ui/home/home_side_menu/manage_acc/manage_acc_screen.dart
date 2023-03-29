import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_me_ii/data_base/my_database.dart';
import 'package:find_me_ii/helpers/dialog_utils.dart';
import 'package:find_me_ii/helpers/my_theme.dart';
import 'package:find_me_ii/helpers/shared_data.dart';
import 'package:find_me_ii/ui/providers/settings_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ManageAcc extends StatefulWidget {
  static const String routeName = 'Manage Account';

  @override
  State<ManageAcc> createState() => _ManageAccState();
}

class _ManageAccState extends State<ManageAcc> {
  String? _image;
  var addressController = TextEditingController();
  var fbController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.editProfile),
        centerTitle: false,
        shape: InputBorder.none,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .05),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.profilePic,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () => _showBottomSheet(),
                      child: Text(
                        AppLocalizations.of(context)!.edit,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.blue),
                      ))
                ],
              ),
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
                  imageUrl:
                  MyDataBase.me.image ?? SharedData.user?.image ?? '',
                  // placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                  const CircleAvatar(
                      child: Icon(CupertinoIcons.person_alt)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .03,
                    bottom: MediaQuery.of(context).size.height * .03),
                color: settingsProvider.isDarkMode()
                    ? MyTheme.coloredTertiary
                    : MyTheme.basicBlack,
                height: MediaQuery.of(context).size.height * .0003,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.details,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {
                        showWidget(
                            context,
                            TextField(
                              controller: addressController,
                              decoration: InputDecoration(
                                  labelText: 'Address',
                                  hintText: 'eg. Benha-Al-Qalubia'),
                            ), posAction: () {
                          if (addressController.text.trim().toString() ==
                                  null ||
                              addressController.text.trim().toString().isEmpty)
                            return;
                          else {
                            MyDataBase.updateUserAddress(
                                address: addressController.text.toString());
                            Dialogs.showSnackbar(
                                context, 'Restart The App To See Changes');
                          }
                        },
                            posActionName: 'Done',
                            negAction: () {},
                            negActionName: 'Cancel');
                      },
                      child: Text(
                        AppLocalizations.of(context)!.edit,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.blue),
                      ))
                ],
              ),
              Row(
                children: [
                  Icon(
                    CupertinoIcons.home,
                    color: settingsProvider.isDarkMode()
                        ? MyTheme.coloredTertiary
                        : Colors.grey,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .045,
                  ),
                  Text(SharedData.user?.gov ??
                      MyDataBase.me.gov ??
                      AppLocalizations.of(context)!.whereDoYouLive)
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .03,
                    bottom: MediaQuery.of(context).size.height * .03),
                color: settingsProvider.isDarkMode()
                    ? MyTheme.coloredTertiary
                    : MyTheme.basicBlack,
                height: MediaQuery.of(context).size.height * .0003,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.links,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        AppLocalizations.of(context)!.edit,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.blue),
                      ))
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .035,
              ),
              Row(
                children: [
                  Icon(
                    Icons.facebook,
                    color: settingsProvider.isDarkMode()
                        ? MyTheme.coloredTertiary
                        : Colors.grey,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .045,
                  ),
                  TextButton(
                    child: Text(SharedData.user?.facebook ??
                        AppLocalizations.of(context)!.addYourFaceBook),
                    onPressed: () {
                      showWidget(
                          context,
                          TextField(
                            controller: fbController,
                            decoration: InputDecoration(
                              labelText: 'Facebook',
                            ),
                          ), posAction: () {
                        if (fbController.text.trim().toString() == null ||
                            addressController.text.trim().toString().isEmpty)
                          return;
                        else {
                          MyDataBase.updateUserFB(
                              fbLink: fbController.text.toString());
                          Dialogs.showSnackbar(
                              context, 'Restart The App To See Changes');
                        }
                      },
                          posActionName: 'Done',
                          negAction: () {},
                          negActionName: 'Cancel');
                    },
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .025,
              ),
              Row(
                children: [
                  ImageIcon(
                    AssetImage('assets/images/instagram.png'),
                    size: MediaQuery.of(context).size.height * .025,
                    color: settingsProvider.isDarkMode()
                        ? MyTheme.coloredTertiary
                        : Colors.grey,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .045,
                  ),
                  Text(SharedData.user?.instagram ??
                      AppLocalizations.of(context)!.addYourInstagram)
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .025,
              ),
              Row(
                children: [
                  ImageIcon(
                    AssetImage('assets/images/whatsapp.png'),
                    size: MediaQuery.of(context).size.height * .025,
                    color: settingsProvider.isDarkMode()
                        ? MyTheme.coloredTertiary
                        : Colors.grey,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .045,
                  ),
                  Text(SharedData.user?.phoneNumber ??
                      AppLocalizations.of(context)!.addYourWhatsApp)
                ],
              )
            ],
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
