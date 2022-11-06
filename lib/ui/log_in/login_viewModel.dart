import 'package:find_me_ii/base/base.dart';
import 'package:find_me_ii/data_base/my_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginNavigator extends BaseNavigator {}

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  var auth = FirebaseAuth.instance;

  void login(String email, String password) async {
    try {
      navigator?.showLoadingDialog();
      var credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      var retrievedUser =
          await MyDataBase.getUserById(credential.user?.uid ?? '');
      navigator?.hideLoadinDialog();
      if (retrievedUser == null) {
        navigator?.showMessageDialog('Something Went Wrong. Try Again Later');
      } else {}
    } on FirebaseAuthException catch (e) {
      navigator?.hideLoadinDialog();
      navigator?.showMessageDialog('Wrong User Name Or Password');
    } catch (e) {
      print(e);
    }
  }
}
