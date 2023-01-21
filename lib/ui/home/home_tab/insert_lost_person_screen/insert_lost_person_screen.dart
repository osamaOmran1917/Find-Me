import 'package:find_me_ii/base/base.dart';
import 'package:find_me_ii/dialog_utils.dart';
import 'package:find_me_ii/shared_data.dart';
import 'package:flutter/material.dart';

import '../../../../my_theme.dart';
import 'add_pic/addin_pic_screen.dart';
import 'insert_lost_person_viewModel.dart';

class InsertLostPersonScreen extends StatefulWidget {
  static const String routeName = 'Insert Missing Person Screen';
  static String id = '';

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
  var formKey = GlobalKey<FormState>();
  bool b1 = false, b2 = false, b3 = false, b4 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
        child: Text(
          'All of this data is optional. But try to fill in all of them so that we can connect the missing with their families, and if you cannot, then fill out at least one statement.',
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
                      decoration: InputDecoration(labelText: 'Name'),
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
                      decoration: InputDecoration(labelText: 'Age'),
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
                          labelText: 'Describe the person you\'ve found'),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: MyTheme.basicWhite,
                        borderRadius: BorderRadius.circular(12)),
                    child: DropdownButton<String>(
                      items: <String>[
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
                      ].map((String value) {
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
                          labelText: 'Where is thies person right now?'),
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
                          Text('Insert'),
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
        showMessage(context, 'Please fill in at least one statement');
        return;
      } else {
        void thenFun = thenMessage();
        void errorFun = onErrorMessage();
        void timeOutFun = timeOutMessage();
        String name = nameController.text.trim().isEmpty
                ? 'Name Not Found'
                : nameController.text,
            gover = gov == 'gov' ? 'Government Not Found' : gov,
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
    showMessage(context, 'Please fill in at least one statement');
  }

  @override
  void thenMessage() {
    showMessage(context, 'Missing Person Inserted Successfuly');
    Navigator.pushReplacementNamed(context, AddPic.routeName,
        arguments: AddPic.missingPerson = viewModel.miss);
  }

  @override
  void onErrorMessage() {
    showMessage(context, 'Something went wrong, try again later');
  }

  @override
  void timeOutMessage() {
    showMessage(context, 'Missing person added');
    Navigator.pushReplacementNamed(context, AddPic.routeName,
        arguments: AddPic.missingPerson = viewModel.miss);
  }
}