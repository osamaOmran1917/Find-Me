import 'package:find_me_ii/base/base.dart';
import 'package:find_me_ii/dialog_utils.dart';
import 'package:find_me_ii/ui/home/home_tab/insert_missing_person_screen/add_pic/addin_pic_screen.dart';
import 'package:flutter/material.dart';

import '../../../../my_theme.dart';
import 'insert_missing_person_viewModel.dart';

class InsertMissingPersonScreen extends StatefulWidget {
  static const String routeName = 'Insert Missing Person Screen';
  static String id = '';

  @override
  State<InsertMissingPersonScreen> createState() =>
      _InsertMissingPersonScreenState();
}

class _InsertMissingPersonScreenState
    extends BaseState<InsertMissingPersonScreen, InsertMissingPersonViewModel>
    implements InsertMissingPersonNavigator {
  @override
  InsertMissingPersonViewModel initViewModel() {
    return InsertMissingPersonViewModel();
  }

  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var describtionController = TextEditingController();
  var addressController = TextEditingController();
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
                color: MyTheme.secondaryColor,
                borderRadius: BorderRadius.circular(40)),
            padding: EdgeInsets.all(12),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: MyTheme.primaryColor,
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
                        color: MyTheme.primaryColor,
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
                        color: MyTheme.primaryColor,
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
                    decoration: BoxDecoration(
                        color: MyTheme.primaryColor,
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
                            MaterialStateProperty.all(MyTheme.tertiaryColor),
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
        String name = nameController.text,
            address = addressController.text,
            desc = describtionController.text,
            age = ageController.text;
        DateTime dateTime = DateTime.now();
        bool? isFound = false;
        viewModel.onAddMissingPersonClicked(
            name, age, desc, address, thenFun, errorFun, timeOutFun);
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
    Navigator.pushReplacementNamed(context, AddPic.routeName);
  }

  @override
  void onErrorMessage() {
    showMessage(context, 'Something went wrong, try again later');
  }

  @override
  void timeOutMessage() {
    showMessage(context, 'Missing person added');
    Navigator.pushReplacementNamed(context, AddPic.routeName,
        arguments: AddPic.id = InsertMissingPersonScreen.id);
  }
}
