import 'package:find_me_ii/base/base.dart';
import 'package:find_me_ii/dialog_utils.dart';
import 'package:flutter/material.dart';

import '../../../../my_theme.dart';
import 'insert_missing_person_viewModel.dart';

class InsertMissingPersonScreen extends StatefulWidget {
  static const String routeName = 'Insert Missing Person Screen';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.tertiaryColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
        child: Text(
          'All of this data is optional. But try to fill in all of them so that we can connect the missing with their families, and if you cannot, then fill out at least one statement.',
          style: TextStyle(fontSize: 10),
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * .8,
          height: MediaQuery.of(context).size.height * .8,
          decoration: BoxDecoration(
              color: MyTheme.secondaryColor,
              borderRadius: BorderRadius.circular(40)),
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Age'),
              ),
              TextField(
                controller: describtionController,
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(
                    labelText: 'Describe the person you are \n searching for'),
              ),
              TextField(
                controller: addressController,
                minLines: 1,
                maxLines: 3,
                decoration: InputDecoration(
                    labelText: 'Where is thies person right now?'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Text('Add photos'), Icon(Icons.add_a_photo)],
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
    );
  }

  void addMissingPerson() {
    if (nameController.text.trim() != null ||
        !(nameController.text.trim().isEmpty) ||
        ageController.text.trim() != null ||
        !(ageController.text.trim().isEmpty) ||
        describtionController.text.trim() != null ||
        !(describtionController.text.trim().isEmpty ||
            addressController.text.trim() != null ||
            !(addressController.text.trim().isEmpty))) {
      String name = nameController.text,
          address = addressController.text,
          desc = describtionController.text,
          age = ageController.text;
      DateTime dateTime = DateTime.now();
      bool? isFound = false;
      viewModel.onAddMissingPersonClicked(name, age, desc, address);
    } else if (nameController.text.isEmpty &&
        nameController.text.trim() == null &&
        ageController.text.isEmpty &&
        ageController.text.trim() == null &&
        describtionController.text.isEmpty &&
        describtionController.text.trim() == null &&
        addressController.text.isEmpty &&
        addressController.text.trim() == null) {
      showMessage(context, 'Please fill in at least one statement');
      //whenNotEnoughData();
    }
  }

  @override
  void whenNotEnoughData() {
    showMessage(context, 'Please fill in at least one statement');
  }
}
