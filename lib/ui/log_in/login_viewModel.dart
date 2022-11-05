import 'package:find_me_ii/base/base.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginNavigator extends BaseNavigator {}

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  var auth = FirebaseAuth.instance;

  void login(String email, String password) async {
    try {
      navigator?.showLoadingDialog();
      var credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      navigator?.hideLoadinDialog();
      navigator?.showMessageDialog(credential.user?.uid ?? '');
    } on FirebaseAuthException catch (e) {
      navigator?.hideLoadinDialog();
      navigator?.showMessageDialog('Wrong User Name Or Password');
    } catch (e) {
      print(e);
    }
  }
}
