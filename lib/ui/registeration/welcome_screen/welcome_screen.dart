import 'package:find_me_ii/my_theme.dart';
import 'package:find_me_ii/ui/home/home_screen.dart';
import 'package:find_me_ii/ui/registeration/complete_user_info/complete_user_info_screen.dart';
import 'package:find_me_ii/ui/registeration/welcome_screen/welcome_screen_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = 'WelcomeScreen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    implements WelcomeScreenNavigator {
  late WelcomeScreenViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = WelcomeScreenViewModel();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Scaffold(
        body: Center(
          child: FadeInDown(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(25)),
              height: MediaQuery.of(context).size.height * .7,
              width: MediaQuery.of(context).size.width * .75,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Welcome!',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: MyTheme.secondaryColor),
                  ),
                  Text(
                    'You have just created your find me account',
                    style:
                        TextStyle(fontSize: 20, color: MyTheme.secondaryColor),
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                      onPressed: () {
                        viewModel.onCompletePrsd();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * .005,
                            horizontal:
                                MediaQuery.of(context).size.width * .0031),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: MyTheme.tertiaryColor, width: 1),
                            borderRadius: BorderRadius.circular(7)),
                        child: Text(
                          'Complete your information',
                          style: TextStyle(
                              fontSize: 20, color: MyTheme.tertiaryColor),
                          textAlign: TextAlign.center,
                        ),
                      )),
                  Text(
                    'Or',
                    style:
                        TextStyle(fontSize: 20, color: MyTheme.secondaryColor),
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                      onPressed: () {
                        viewModel.onSkipPrsd();
                      },
                      child: Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height * .005),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: MyTheme.tertiaryColor, width: 1),
                            borderRadius: BorderRadius.circular(7)),
                        child: Text(
                          'Skip',
                          style: TextStyle(
                              fontSize: 20, color: MyTheme.tertiaryColor),
                          textAlign: TextAlign.center,
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void goToCompleteInfoPage() {
    Navigator.pushReplacementNamed(context, CompleteUserInfo.routeName);
  }

  @override
  void goToHome() {
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
}
