import 'dart:developer';
import 'dart:io';

import 'package:find_me_ii/base/base.dart';
import 'package:find_me_ii/dialog_utils.dart';
import 'package:find_me_ii/my_theme.dart';
import 'package:find_me_ii/ui/home/home_screen.dart';
import 'package:find_me_ii/ui/log_in/login_viewModel.dart';
import 'package:find_me_ii/ui/providers/settings_provider.dart';
import 'package:find_me_ii/ui/registeration/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../validation_utils.dart';

class LogInScreen extends StatefulWidget {
  static const String routeName = 'Log In Screen';

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends BaseState<LogInScreen, LoginViewModel>
    implements LoginNavigator {
  bool securePasswordI = true;
  bool securePasswordII = true;
  var formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }

  _handleGoogleBtnClick() {
    Dialogs.showProgressBar(context);
    _signInWithGoogle().then((user) {
      Navigator.pop(context);
      if (user != null) {
        log('\n${AppLocalizations.of(context)!.user}: ${user.user}');
        log('\n${AppLocalizations.of(context)!.userAdditionalInfo}: ${user.additionalUserInfo}');
        Navigator.pushReplacementNamed(context, HomeScreen.routeName,
            arguments: HomeScreen.selectedIndex = 0);
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
          context,
          AppLocalizations.of(context)!
              .somethingWentWrongCheckInternetConnection);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    viewModel.checkLoggedInUser();
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * .05),
        child: AppBar(
          shape: Theme.of(context).appBarTheme.shape,
          centerTitle: true,
          title: Text(AppLocalizations.of(context)!.app_title),
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
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          TextFormField(
                            controller: emailController,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return AppLocalizations.of(context)!
                                    .emailAdressIsRequired;
                              }
                              if (!ValidationUtils.isValidEmail(text)) {
                                return AppLocalizations.of(context)!
                                    .pleasEnterAValidEmail;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText:
                                AppLocalizations.of(context)!.emailAdress),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          TextFormField(
                            controller: passwordController,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return AppLocalizations.of(context)!
                                    .pleaseEnterPassword;
                              }
                              if (text.length < 6) {
                                return AppLocalizations.of(context)!
                                    .passwordMustBeAtLeastSixCharacters;
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
                                labelText:
                                AppLocalizations.of(context)!.password),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .09,
                          ),
                          ElevatedButton(
                            child: Text(
                              AppLocalizations.of(context)!.login,
                              style: TextStyle(color: MyTheme.basicWhite),
                            ),
                            onPressed: () {
                              signIn();
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
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
                                  backgroundColor: settingsProvider.isDarkMode()
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
                                          '${AppLocalizations.of(context)!.loginWith} '),
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
                          Center(
                              child: Text(
                                AppLocalizations.of(context)!.or,
                                style: TextStyle(color: MyTheme.basicBlue),
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, RegisterScreen.routeName);
                              },
                              child: Text(
                                  AppLocalizations.of(context)!
                                      .createNewAccount,
                                  style: TextStyle(color: MyTheme.basicBlue)))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .25,
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

  void signIn() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    viewModel.login(emailController.text, passwordController.text);
  }

  @override
  void goToHome() {
    Navigator.pushReplacementNamed(context, HomeScreen.routeName,
        arguments: HomeScreen.selectedIndex = 0);
  }
}
