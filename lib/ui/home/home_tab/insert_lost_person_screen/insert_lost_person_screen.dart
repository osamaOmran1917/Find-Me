import 'package:find_me_ii/base/base.dart';
import 'package:find_me_ii/dialog_utils.dart';
import 'package:find_me_ii/shared_data.dart';
import 'package:find_me_ii/ui/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
                          Icon(InsertLostPersonScreen.lost
                              ? Icons.add_circle_outlined
                              : Icons.add_a_photo),
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
        String name = nameController.text.trim().isEmpty
                ? AppLocalizations.of(context)!.nameNotAvailable
                : nameController.text,
            gover = gov == 'gov'
                ? AppLocalizations.of(context)!.govNotAvailable
                : gov,
            userId = SharedData.user?.id ?? '',
            address = addressController.text,
            desc = describtionController.text,
            age = ageController.text;
        DateTime dateTime = DateTime.now();
        bool? isFound = false;

        viewModel.onAddMissingPersonClicked(name, age, desc, gover, userId,
            address, thenFun, errorFun, timeOutFun);
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
    Navigator.pushReplacementNamed(context, AddPic.routeName,
        arguments: AddPic.missingPersonId = InsertLostPersonScreen.id);
  }

  @override
  void onErrorMessage() {
    showMessage(
        context, AppLocalizations.of(context)!.somethingWentWrongTryAgainLater);
  }

  @override
  void timeOutMessage() {
    showMessage(context, AppLocalizations.of(context)!.missingPersonAdded);
    Navigator.pushReplacementNamed(context, AddPic.routeName,
        arguments: AddPic.missingPersonId = InsertLostPersonScreen.id);
  }
}