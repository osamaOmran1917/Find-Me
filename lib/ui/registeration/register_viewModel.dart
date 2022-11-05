import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class RegisterNavigator {
  void showLoadingDialog({String message = 'Loading..'});

  void hideLoadinDialog();

  void showMessageDialog(String message);
}

class RegisterViewModel extends ChangeNotifier {
  RegisterNavigator? navigator;
  var auth = FirebaseAuth.instance;

  void register(String email, String password) async {
    navigator?.showLoadingDialog();
    try {
      var credentials = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      navigator?.hideLoadinDialog();
      navigator?.showMessageDialog(credentials.user?.uid ?? '');
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
