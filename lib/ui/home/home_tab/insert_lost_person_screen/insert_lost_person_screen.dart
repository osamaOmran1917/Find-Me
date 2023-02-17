import 'dart:developer';
import 'dart:io';

import 'package:find_me_ii/base/base.dart';
import 'package:find_me_ii/data_base/missing_person.dart';
import 'package:find_me_ii/data_base/my_database.dart';
import 'package:find_me_ii/dialog_utils.dart';
import 'package:find_me_ii/shared_data.dart';
import 'package:find_me_ii/ui/home/home_screen.dart';
import 'package:find_me_ii/ui/providers/settings_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../my_theme.dart';
import 'add_pic/addin_pic_screen.dart';
import 'insert_lost_person_viewModel.dart';

class InsertLostPersonScreen extends StatefulWidget {
  static const String routeName = 'Insert Missing Person Screen';
  static String id = '';
  static bool lost = true;

  @override
  State<InsertLostPersonScreen> createState() => _InsertLostPersonScreenState();
}

class _InsertLostPersonScreenState
    extends BaseState<InsertLostPersonScreen, InsertLostPersonViewModel>
    implements InsertLostPersonNavigator {
  @override
  InsertLostPersonViewModel initViewModel() {
    return InsertLostPersonViewModel();
  }

  String? _image;
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var describtionController = TextEditingController();
  var addressController = TextEditingController();
  String gov = 'gov';
  List<String> govs = [
    'Alexandria',
    'Ismailia',
    'Aswan',
    'Assiut',
    'Luxor',
    'Red Sea',
    'Buhaira',
    'Beni Suef',
    'Port Said',
    'South Sinai',
    'Giza',
    'Dakahlia',
    'Damietta',
    'Sohag',
    'Suez',
    'Sharkia',
    'North Sinai',
    'Gharbia',
    'Fayoum',
    'Cairo',
    'Qalyubia',
    'Qena',
    'Kafr El Sheikh',
    'Marsa Matrouh',
    'Menoufia',
    'Minya',
    'New Valley'
  ];
  List<String> govsAR = [
    'الإسكندرية',
    'الإسماعيلية',
    'أسوان',
    'أسيوط',
    'الأقصر',
    'البحر الأحمر',
    'البحيرة',
    'بني سويف',
    'بور سعيد',
    'جنوب سيناء',
    'الجيزة',
    'الدقهلية',
    'دمياط',
    'سوهاج',
    'السويس',
    'الشرقية',
    'شمال سيناء',
    'الغربية',
    'الفيوم',
    'القاهرة',
    'القليوبية',
    'قنا',
    'كفر الشيخ',
    'مرسى مطروح',
    'المنوفية',
    'المنيا',
    'الوادي الجديد'
  ];
  var formKey = GlobalKey<FormState>();
  bool b1 = false, b2 = false, b3 = false, b4 = false;

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
        child: Text(
          AppLocalizations.of(context)!
              .allOfThisDataIsOptionalButTryToFillInAllOfThemSoThatWeCanConnectTheMissingWithTheirFamiliesAndIfYouCannotThenFillOutAtLeastOneStatement,
          style: TextStyle(fontSize: 10),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width * .8,
            height: MediaQuery.of(context).size.height * .8,
            decoration: BoxDecoration(
                color: MyTheme.coloredSecondary,
                borderRadius: BorderRadius.circular(40)),
            padding: EdgeInsets.all(12),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: MyTheme.basicWhite,
                        borderRadius: BorderRadius.circular(12)),
                    child: TextFormField(
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          b1 = true;
                          return null;
                        } else {
                          b1 = false;
                          return null;
                        }
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.name),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: MyTheme.basicWhite,
                        borderRadius: BorderRadius.circular(12)),
                    child: TextFormField(
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          b2 = true;
                          return null;
                        } else {
                          b2 = false;
                          return null;
                        }
                      },
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.age),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: MyTheme.basicWhite,
                        borderRadius: BorderRadius.circular(12)),
                    child: TextFormField(
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          b3 = true;
                          return null;
                        } else {
                          b3 = false;
                          return null;
                        }
                      },
                      controller: describtionController,
                      minLines: 1,
                      maxLines: 5,
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!
                              .describeThePersonYouVeFound),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: MyTheme.basicWhite,
                        borderRadius: BorderRadius.circular(12)),
                    child: settingsProvider.currentLang == 'en'
                        ? DropdownButton<String>(
                      items: govs.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text(gov),
                      onChanged: (value) {
                        setState(() {
                          gov = value.toString();
                        });
                      },
                    )
                        : DropdownButton<String>(
                      items: govsAR.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text(gov),
                      onChanged: (value) {
                        setState(() {
                          gov = value.toString();
                        });
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: MyTheme.basicWhite,
                        borderRadius: BorderRadius.circular(12)),
                    child: TextFormField(
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          b4 = true;
                          return null;
                        } else {
                          b4 = false;
                          return null;
                        }
                      },
                      controller: addressController,
                      minLines: 1,
                      maxLines: 3,
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!
                              .whereIsThiesPersonRightNow),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _showBottomSheet();
                    },
                    icon: Icon(
                      CupertinoIcons.photo,
                      size: 25,
                    ),
                    label: Text(
                      AppLocalizations.of(context)!.addPicToThisPerson,
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        minimumSize: Size(
                            MediaQuery
                                .of(context)
                                .size
                                .width * .5,
                            MediaQuery
                                .of(context)
                                .size
                                .height * .06)),
                  ),
                  _image != null ? ClipRRect(
                    borderRadius: BorderRadius.circular(
                        MediaQuery
                            .of(context)
                            .size
                            .height * .1),
                    child: Image.file(
                      File(_image!),
                      width: MediaQuery
                          .of(context)
                          .size
                          .height * .2,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * .2,
                      fit: BoxFit.cover,
                    ),
                  ) : Container(
                    height: 0,
                    width: 0,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )),
                        backgroundColor:
                        MaterialStateProperty.all(MyTheme.basicBlue),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                      ),
                      onPressed: () {
                        addMissingPerson();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(AppLocalizations.of(context)!.insert),
                          Icon(Icons.add_circle_outlined),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addMissingPerson() {
    if (formKey.currentState?.validate() == true) {
      if (b1 && b2 && b3 && b4) {
        showMessage(context,
            AppLocalizations.of(context)!.pleaseFillInAtLeastOneStatement);
        return;
      } else {
        void thenFun = thenMessage();
        void errorFun = onErrorMessage();
        void timeOutFun = timeOutMessage();
        String name = nameController.text
            .trim()
            .isEmpty
            ? AppLocalizations.of(context)!.nameNotAvailable
            : nameController.text,
            gover = gov == 'gov'
                ? AppLocalizations.of(context)!.govNotAvailable
                : gov,
            userId = SharedData.user?.id ?? '',
            address = addressController.text,
            desc = describtionController.text,
            age = ageController.text,
            image = _image!;

        DateTime dateTime = DateTime.now();

        onAddMissingPersonClicked(
            name,
            age,
            desc,
            gover,
            userId,
            address,
            image,
            !InsertLostPersonScreen.lost,
            thenFun,
            errorFun,
            timeOutFun);
      }
    } else
      return;
  }

  @override
  void whenNotEnoughData() {
    showMessage(
        context, AppLocalizations.of(context)!.pleaseFillInAtLeastOneStatement);
  }

  @override
  void thenMessage() {
    showMessage(context,
        AppLocalizations.of(context)!.missingPersonInsertedSuccessfuly);
    /*Navigator.pushReplacementNamed(context, AddPic.routeName,
        arguments: AddPic.missingPersonId = InsertLostPersonScreen.id);*/
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => HomeScreen()));
    print('ال أيدي     يييييييييييييييي${AddPic.missingPersonId}');
  }

  @override
  void onErrorMessage() {
    showMessage(
        context, AppLocalizations.of(context)!.somethingWentWrongTryAgainLater);
  }

  @override
  void timeOutMessage() {
    showMessage(context, AppLocalizations.of(context)!.missingPersonAdded);
    /*Navigator.pushReplacementNamed(context, AddPic.routeName,
        arguments: AddPic.missingPersonId = InsertLostPersonScreen.id);*/
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => HomeScreen()));
  }


  //كانت في الviewmodel أصلا و جبتها هنا تجربة
  Future<void> onAddMissingPersonClicked(
      String name,
      String age,
      String desc,
      String gov,
      String userId,
      String address,
      String image,
      bool foundPerson,
      void thenFun,
      void errorFun,
      void timeOutFun) async {
    MissingPerson missingPerson = MissingPerson(
        name: name,
        age: age,
        desc: desc,
        gov: gov,
        adress: address,
        image: _image ?? '',
        dateTime: DateTime.now(),
        reachedToFamily: false,
        posterId: SharedData.user?.id,
        posterName: SharedData.user?.userName,
        foundPerson: foundPerson);
    MyDataBase.insertMissingPerson(missingPerson).then((value) async {
      //called when future is completed
      thenFun;
      InsertLostPersonScreen.id = missingPerson.id!;
    }).onError((error, stackTrace) {
      //called when future fails
      errorFun;
    }).timeout(Duration(seconds: 15), onTimeout: () async {
      //save changes in cache
      timeOutFun;
      InsertLostPersonScreen.id = missingPerson.id!;
    });
    final ext = File(_image!).path.split('.').last;
    final ref = MyDataBase.storage
        .ref()
        .child('lost_people_pictures/${missingPerson.id}.$ext');
    await ref.putFile(
        File(_image!), SettableMetadata(contentType: 'image/$ext'));
    missingPerson.image = await ref.getDownloadURL();
    await MyDataBase.firestore
        .collection('Missing Person')
        .doc(missingPerson.id)
        .update({'image': missingPerson.image});
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(
                top: MediaQuery
                    .of(context)
                    .size
                    .height * .02,
                bottom: MediaQuery
                    .of(context)
                    .size
                    .height * .05),
            children: [
              Text(
                'Pick a picture',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: CircleBorder(),
                          fixedSize: Size(
                              MediaQuery
                                  .of(context)
                                  .size
                                  .width * .3,
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * .15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        // Pick an image
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 80);
                        if (image != null) {
                          log('Image path: ${image.path} -- MimeType ${image.mimeType}');
                          setState(() {
                            _image = image.path;
                            print(
                                ' أهيييييييييييييييي  ************************** الصورةةةةةةةةةةة$_image');
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: Image.asset('assets/images/picture.png')),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: CircleBorder(),
                          fixedSize: Size(
                              MediaQuery
                                  .of(context)
                                  .size
                                  .width * .3,
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * .15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        // Pick an image
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.camera, imageQuality: 80);
                        if (image != null) {
                          log('Image path: ${image.path}');
                          setState(() {
                            _image = image.path;
                          });
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