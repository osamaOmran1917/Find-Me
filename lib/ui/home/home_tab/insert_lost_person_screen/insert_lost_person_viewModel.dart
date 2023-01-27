import 'package:find_me_ii/base/base.dart';
import 'package:find_me_ii/data_base/missing_person.dart';
import 'package:find_me_ii/data_base/my_database.dart';

import 'insert_lost_person_screen.dart';

abstract class InsertLostPersonNavigator extends BaseNavigator {
  void whenNotEnoughData();

  void thenMessage();

  void onErrorMessage();

  void timeOutMessage();
}

class InsertLostPersonViewModel
    extends BaseViewModel<InsertLostPersonNavigator> {
  MissingPerson? miss;

  void onAddMissingPersonClicked(
      String name,
      String age,
      String desc,
      String gov,
      String userId,
      String address,
      void thenFun,
      void errorFun,
      void timeOutFun) {
    MissingPerson missingPerson = MissingPerson(
        name: name,
        age: age,
        desc: desc,
        gov: gov,
        adress: address,
        dateTime: DateTime.now(),
        reachedToFamily: false);
    MyDataBase.insertMissingPerson(missingPerson).then((value) {
      //called when future is completed
      thenFun;
      InsertLostPersonScreen.id = missingPerson.id!;
    }).onError((error, stackTrace) {
      //called when future fails
      errorFun;
    }).timeout(Duration(seconds: 15), onTimeout: () {
      //save changes in cache
      timeOutFun;
      InsertLostPersonScreen.id = missingPerson.id!;
    });

    miss = missingPerson;
  }
}
