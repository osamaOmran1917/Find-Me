import 'package:find_me_ii/dialog_utils.dart';
import 'package:find_me_ii/ui/log_in/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../validation_utils.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'Register Screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool securePasswordI = true;
  bool securePasswordII = true;
  var formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
        Size.fromHeight(MediaQuery
            .of(context)
            .size
            .height * .05),
        child: AppBar(
          shape: Theme
              .of(context)
              .appBarTheme
              .shape,
          centerTitle: true,
          title: Text('Find Me'),
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .12,
                ),
                TextFormField(
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'User Name Is Required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'User Name'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                TextFormField(
                  controller: emailController,
                  validator: (text) {
                    if (text == null || text
                        .trim()
                        .isEmpty) {
                      return 'E-mail Adress Is Required';
                    }
                    if (!ValidationUtils.isValidEmail(text)) {
                      return 'Pleas Enter A Valid E-mail';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'E-mail Adress'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                TextFormField(
                  controller: passwordController,
                  validator: (text) {
                    if (text == null || text
                        .trim()
                        .isEmpty) {
                      return 'Please Enter Password';
                    }
                    if (text.length < 6) {
                      return 'Passord Must Be At Least 6 Characters.';
                    }
                    return null;
                  },
                  obscureText: securePasswordI,
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                          onTap: () {
                            securePasswordI = !securePasswordI;
                            setState(() {});
                          },
                          child: Icon(securePasswordI
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      labelText: 'Password'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                TextFormField(
                  validator: (text) {
                    if (text == null || text
                        .trim()
                        .isEmpty) {
                      return 'Please Confirm Password';
                    }
                    if (text != passwordController.text) {
                      return 'The Two Passwords Are Not Identical.';
                    }
                    return null;
                  },
                  obscureText: securePasswordII,
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                          onTap: () {
                            securePasswordII = !securePasswordII;
                            setState(() {});
                          },
                          child: Icon(securePasswordII
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      labelText: 'Confirm Password'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .09,
                ),
                ElevatedButton(
                  child: Text(
                    'Create Account',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onPressed: () {
                    createAccountClicked();
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red))),
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, LogInScreen.routeName);
                    },
                    child: Text('Already Have An Account?',
                        style:
                            TextStyle(color: Theme.of(context).primaryColor)))
              ],
            ),
          ),
        ),
      ),
    );
  }

  var authService = FirebaseAuth.instance;

  void createAccountClicked() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    showLoading(context, 'Loading..');
    authService.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text).then((
        userCredential) {
      hideLoading(context);
      showMessage(context, userCredential.user?.uid ?? '');
    }).onError((error, stackTrace) {
      hideLoading(context);
      showMessage(context, error.toString());
    });
  }
}