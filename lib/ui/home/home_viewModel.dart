import '../../base/base.dart';

abstract class HomeNavigator extends BaseNavigator {
  // void goToHome();
}

class HomeViewModel extends BaseViewModel<HomeNavigator> {
  // var auth = FirebaseAuth.instance;

  /*void login(String email, String password) async {
    try {
      navigator?.showLoadingDialog();
      var credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      var retrievedUser =
      await MyDataBase.getUserById(credential.user?.uid ?? '');
      navigator?.hideLoadinDialog();
      if (retrievedUser == null) {
        navigator?.showMessageDialog('Something Went Wrong. Try Again Later');
      } else {
        SharedData.user = retrievedUser;
        navigator?.goToHome();
      }
    } on FirebaseAuthException catch (e) {
      navigator?.hideLoadinDialog();
      navigator?.showMessageDialog('Wrong User Name Or Password');
    } catch (e) {
      print(e);
    }
  }*/
}
