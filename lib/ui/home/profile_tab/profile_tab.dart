import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_me_ii/data_base/missing_person.dart';
import 'package:find_me_ii/data_base/my_database.dart';
import 'package:find_me_ii/helpers/dialog_utils.dart';
import 'package:find_me_ii/helpers/log_out.dart';
import 'package:find_me_ii/helpers/my_theme.dart';
import 'package:find_me_ii/helpers/shared_data.dart';
import 'package:find_me_ii/model/my_user.dart';
import 'package:find_me_ii/ui/home/latest_missing_tab/post_details.dart';
import 'package:find_me_ii/ui/widgets/post_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

class ProfileTab extends StatefulWidget {
  final MyUser user;

  const ProfileTab({super.key, required this.user});

  static const String routeName = 'Profile Tab';

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
            onPressed: () {
              logOut(context);
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
              physics: BouncingScrollPhysics(),
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
                    validator: (val) => val != null && val.isNotEmpty
                        ? null
                        : AppLocalizations.of(context)!.requiredField,
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
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.numberWithOptions(),
                    maxLength: 11,
                    validator: (val) =>
                    val!.length > 0 && val.length < 11
                        ? AppLocalizations.of(context)!
                        .pleasEnterAValidPhoneNumber
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
                        hintText: AppLocalizations.of(context)!.egphone,
                        label: Text(AppLocalizations.of(context)!.phoneNumber)),
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
                              context,
                              AppLocalizations.of(context)!
                                  .profileUpdatedSuccessfully);
                        });
                      }
                    },
                    icon: Icon(
                      Icons.edit,
                      size: 25,
                    ),
                    label: Text(
                      AppLocalizations.of(context)!.update,
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        minimumSize: Size(
                            MediaQuery.of(context).size.width * .5,
                            MediaQuery.of(context).size.height * .06)),
                  ),
                  StreamBuilder<QuerySnapshot<MissingPerson>>(
                    builder: (buildContext, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(AppLocalizations.of(context)!
                              .errorLoadingDataTryAgainLater),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                              color: MyTheme.coloredSecondary),
                        );
                      }
                      var data =
                      snapshot.data?.docs.map((e) => e.data()).toList();
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (buildContext, index) {
                          return data.isEmpty
                              ? Center(
                            child: Text(
                              AppLocalizations.of(context)!.noLostPeople,
                              style: TextStyle(
                                  color: MyTheme.coloredSecondary,
                                  fontSize: 30),
                            ),
                          )
                              : InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, PostDetails.routeName,
                                    arguments: SharedData.missingPerson =
                                    data[index]);
                                print(data[index].id);
                              },
                              child: PostWidget(data[index]));
                        },
                        itemCount: data!.length,
                      );
                    },
                    stream: MyDataBase
                        .listenForMissingPersonsRealTimeUpdatesDependingOnUser(
                        SharedData.user!),
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
