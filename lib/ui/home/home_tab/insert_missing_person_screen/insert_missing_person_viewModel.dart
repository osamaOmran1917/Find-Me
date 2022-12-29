import 'package:find_me_ii/base/base.dart';
import 'package:find_me_ii/data_base/missing_person.dart';
import 'package:find_me_ii/data_base/my_database.dart';
import 'package:find_me_ii/ui/home/home_tab/insert_missing_person_screen/insert_missing_person_screen.dart';

abstract class InsertMissingPersonNavigator extends BaseNavigator {
  void whenNotEnoughData();

  void thenMessage();

  void onErrorMessage();

  void timeOutMessage();
}

class InsertMissingPersonViewModel
    extends BaseViewModel<InsertMissingPersonNavigator> {
  void onAddMissingPersonClicked(String name, String age, String desc,
      String address, void thenFun, void errorFun, void timeOutFun) {
    MissingPerson missingPerson = MissingPerson(
        name: name,
        age: age,
        desc: desc,
        adress: address,
        dateTime: DateTime.now(),
        isFound: false);
    MyDataBase.insertMissingPerson(missingPerson).then((value) {
      //called when future is completed
      thenFun;
      InsertMissingPersonScreen.id = missingPerson.id!;
    }).onError((error, stackTrace) {
      //called when future fails
      errorFun;
    }).timeout(Duration(seconds: 15), onTimeout: () {
      //save changes in cache
      timeOutFun;
      InsertMissingPersonScreen.id = missingPerson.id!;
    });
  }
}