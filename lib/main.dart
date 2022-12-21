import 'package:find_me_ii/firebase_options.dart';
import 'package:find_me_ii/my_theme.dart';
import 'package:find_me_ii/ui/home/home_screen.dart';
import 'package:find_me_ii/ui/home/home_side_menu/about_us/about_us_screen.dart';
import 'package:find_me_ii/ui/home/home_side_menu/contact_us/contact_us_screen.dart';
import 'package:find_me_ii/ui/home/home_side_menu/manage_acc/manage_acc_screen.dart';
import 'package:find_me_ii/ui/home/home_tab/insert_missing_person_screen/insert_missing_person_screen.dart';
import 'package:find_me_ii/ui/home/home_tab/search_screen/search_screen.dart';
import 'package:find_me_ii/ui/log_in/login_screen.dart';
import 'package:find_me_ii/ui/registeration/complete_user_info/complete_user_info_screen.dart';
import 'package:find_me_ii/ui/registeration/phone_number_section/enter_phone_number_screen.dart';
import 'package:find_me_ii/ui/registeration/register_screen.dart';
import 'package:find_me_ii/ui/registeration/welcome_screen/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTheme.lightTheme,
      initialRoute: LogInScreen.routeName,
      routes: {
        LogInScreen.routeName: (_) => LogInScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        SearchScreen.routeName: (_) => SearchScreen(),
        InsertMissingPersonScreen.routeName: (_) => InsertMissingPersonScreen(),
        EnterPhoneNumberScreen.routeName: (_) => EnterPhoneNumberScreen(),
        ManageAcc.routeName: (_) => ManageAcc(),
        AboutUs.routeName: (_) => AboutUs(),
        ContactUs.routeName: (_) => ContactUs(),
        CompleteUserInfo.routeName: (_) => CompleteUserInfo(),
        WelcomeScreen.routeName: (_) => WelcomeScreen()
      },
    );
  }
}
