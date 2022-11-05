import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class LoginNavigator {
  void showLoadingDialog({String message = 'Loading..'});

  void hideLoadinDialog();

  void showMessageDialog(String message);
}

class LoginViewModel extends ChangeNotifier {
  LoginNavigator? navigator;
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
