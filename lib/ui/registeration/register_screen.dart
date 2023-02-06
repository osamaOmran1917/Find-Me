import 'dart:developer';
import 'dart:io';

import 'package:find_me_ii/base/base.dart';
import 'package:find_me_ii/dialog_utils.dart';
import 'package:find_me_ii/my_theme.dart';
import 'package:find_me_ii/ui/log_in/login_screen.dart';
import 'package:find_me_ii/ui/providers/settings_provider.dart';
import 'package:find_me_ii/ui/registeration/register_viewModel.dart';
import 'package:find_me_ii/ui/registeration/welcome_screen/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../validation_utils.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'Register Screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseState<RegisterScreen, RegisterViewModel>
    implements RegisterNavigator {
  bool securePasswordI = true;
  bool securePasswordII = true;
  var formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  RegisterViewModel initViewModel() {
    return RegisterViewModel();
  }

  _handleGoogleBtnClick() {
    Dialogs.showProgressBar(context);
    _signInWithGoogle().then((user) {
      Navigator.pop(context);
      if (user != null) {
        log('\nUser: ${user.user}');
        log('\nUserAdditionalInfo: ${user.additionalUserInfo}');
        Navigator.pushReplacementNamed(context, WelcomeScreen.routeName);
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      log('\n_signInWithGoogle: $e');
      Dialogs.showSnackbar(
          context, 'Something went wrong (Check Internet Connection)!');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * .05),
        child: AppBar(
          shape: Theme.of(context).appBarTheme.shape,
          centerTitle: true,
          title: Text('Find Me'),
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: Theme.of(context).primaryColor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .8,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              controller: userNameController,
                              validator: (text) {
                                if (text == null || text.trim().isEmpty) {
                                  return 'User Name Is Required';
                                }
                                return null;
                              },
                              decoration:
                                  InputDecoration(labelText: 'User Name'),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .02,
                            ),
                            TextFormField(
                              controller: emailController,
                              validator: (text) {
                                if (text == null || text.trim().isEmpty) {
                                  return 'E-mail Adress Is Required';
                                }
                                if (!ValidationUtils.isValidEmail(text)) {
                                  return 'Pleas Enter A Valid E-mail';
                                }
                                return null;
                              },
                              decoration:
                                  InputDecoration(labelText: 'E-mail Adress'),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .02,
                            ),
                            TextFormField(
                              controller: passwordController,
                              validator: (text) {
                                if (text == null || text.trim().isEmpty) {
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
                                if (text == null || text.trim().isEmpty) {
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
                                style: TextStyle(color: MyTheme.basicWhite),
                              ),
                              onPressed: () {
                                createAccountClicked();
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(
                                            color: MyTheme.basicBlue))),
                                backgroundColor: MaterialStateProperty.all(
                                    settingsProvider.isDarkMode()
                                        ? MyTheme.coloredSecondary
                                        : MyTheme.basicBlack),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 15)),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .02,
                            ),
                            ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        settingsProvider.isDarkMode()
                                            ? MyTheme.coloredTertiary
                                            : MyTheme.basicBlack,
                                    shape: StadiumBorder(),
                                    elevation: 1),
                                onPressed: () {
                                  _handleGoogleBtnClick();
                                },
                                icon: Image.asset(
                                  'assets/images/googleIcon.png',
                                  height:
                                      MediaQuery.of(context).size.height * .03,
                                ),
                                label: RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          color: MyTheme.basicWhite,
                                          fontSize: 16),
                                      children: [
                                        TextSpan(
                                            text:
                                                '${AppLocalizations.of(context)!.registerWith} '),
                                        TextSpan(
                                            text: AppLocalizations.of(context)!
                                                .google,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500)),
                                      ]),
                                )),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .02,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, LogInScreen.routeName);
                                },
                                child: Text('Already Have An Account?',
                                    style: TextStyle(color: MyTheme.basicBlue)))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              settingsProvider.changeTheme(
                                  settingsProvider.isDarkMode()
                                      ? ThemeMode.light
                                      : ThemeMode.dark);
                            },
                            child: Text(settingsProvider.isDarkMode()
                                ? AppLocalizations.of(context)!.basic
                                : AppLocalizations.of(context)!.colored)),
                        TextButton(
                            onPressed: () {
                              settingsProvider.changeLanguage(
                                  settingsProvider.currentLang == 'en'
                                      ? 'ar'
                                      : 'en');
                            },
                            child: Text(settingsProvider.currentLang == 'en'
                                ? 'العربية'
                                : 'English'))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void createAccountClicked() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    viewModel.register(
        emailController.text, passwordController.text, userNameController.text);
  }

  @override
  void goToWelcomeScreen() {
    Navigator.pushReplacementNamed(context, WelcomeScreen.routeName);
  }
}