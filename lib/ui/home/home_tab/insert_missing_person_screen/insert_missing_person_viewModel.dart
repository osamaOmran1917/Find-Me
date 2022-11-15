import 'package:find_me_ii/base/base.dart';
import 'package:find_me_ii/data_base/missing_person.dart';
import 'package:find_me_ii/data_base/my_database.dart';

abstract class InsertMissingPersonNavigator extends BaseNavigator {
  void whenNotEnoughData();
}

class InsertMissingPersonViewModel
    extends BaseViewModel<InsertMissingPersonNavigator> {
  void onAddMissingPersonClicked(
      String name, String age, String desc, String address) {
    MissingPerson missingPerson = MissingPerson(
        name: name,
        age: age,
        desc: desc,
        address: address,
        dateTime: DateTime.now(),
        isFound: false);
    MyDataBase.insertMissingPerson(missingPerson).then((value) {
      //called when future is completed
    }).onError((error, stackTrace) {
      //called when future fails
    }).timeout(Duration(seconds: 15), onTimeout: () {
      //save changes in cache
    });
  }
}
