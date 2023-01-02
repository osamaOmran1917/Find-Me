import 'package:find_me_ii/base/base.dart';
import 'package:find_me_ii/data_base/my_database.dart';
import 'package:find_me_ii/model/my_user.dart';
import 'package:find_me_ii/shared_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RegisterNavigator extends BaseNavigator {
  void goToWelcomeScreen();
}

class RegisterViewModel extends BaseViewModel<RegisterNavigator> {
  var auth = FirebaseAuth.instance;

  void register(String email, String password, String userName) async {
    navigator?.showLoadingDialog();
    try {
      var credentials = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      MyUser newUser =
          MyUser(id: credentials.user?.uid, userName: userName, email: email);
      var insertedUser = await MyDataBase.insertUser(newUser);
      navigator?.hideLoadinDialog();
      if (insertedUser != null) {
        SharedData.user = insertedUser;
        navigator?.goToWelcomeScreen();
      } else {
        navigator
            ?.showMessageDialog('Something Went Wrong. Error With DataBase');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        navigator?.showMessageDialog('Password Is Too Weak');
      } else if (e.code == 'email-already-in-use') {
        navigator?.showMessageDialog('Email Is Already Registered');
      }
    } catch (e) {
      navigator?.hideLoadinDialog();
      navigator
          ?.showMessageDialog('Something Went Wrong. Please Try Again Later');
    }
  }
}