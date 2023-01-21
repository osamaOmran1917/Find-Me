import 'package:find_me_ii/firebase_options.dart';
import 'package:find_me_ii/my_theme.dart';
import 'package:find_me_ii/ui/home/chat/chat_screen.dart';
import 'package:find_me_ii/ui/home/home_screen.dart';
import 'package:find_me_ii/ui/home/home_side_menu/about_us/about_us_screen.dart';
import 'package:find_me_ii/ui/home/home_side_menu/contact_us/contact_us_screen.dart';
import 'package:find_me_ii/ui/home/home_side_menu/inbox/inbox_screen.dart';
import 'package:find_me_ii/ui/home/home_side_menu/manage_acc/manage_acc_screen.dart';
import 'package:find_me_ii/ui/home/home_tab/insert_lost_person_screen/add_pic/addin_pic_screen.dart';
import 'package:find_me_ii/ui/home/home_tab/insert_lost_person_screen/insert_lost_person_screen.dart';
import 'package:find_me_ii/ui/home/home_tab/post_details.dart';
import 'package:find_me_ii/ui/home/home_tab/search_screen/search_screen.dart';
import 'package:find_me_ii/ui/log_in/login_screen.dart';
import 'package:find_me_ii/ui/providers/settings_provider.dart';
import 'package:find_me_ii/ui/registeration/complete_user_info/complete_user_info_screen.dart';
import 'package:find_me_ii/ui/registeration/phone_number_section/enter_phone_number_screen.dart';
import 'package:find_me_ii/ui/registeration/register_screen.dart';
import 'package:find_me_ii/ui/registeration/welcome_screen/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider<SettingsProvider>(
      create: (buildContext) {
        return SettingsProvider();
      },
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  late SettingsProvider settingsProvider;

  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of<SettingsProvider>(context);
    getValueFromShared();
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // Arabic
      ],
      locale: Locale(settingsProvider.currentLang),
      theme: MyTheme.basicTheme,
      darkTheme: MyTheme.coloredTheme,
      themeMode: settingsProvider.currentTheme,
      initialRoute: LogInScreen.routeName,
      routes: {
        LogInScreen.routeName: (_) => LogInScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        SearchScreen.routeName: (_) => SearchScreen(),
        InsertLostPersonScreen.routeName: (_) => InsertLostPersonScreen(),
        EnterPhoneNumberScreen.routeName: (_) => EnterPhoneNumberScreen(),
        ManageAcc.routeName: (_) => ManageAcc(),
        AboutUs.routeName: (_) => AboutUs(),
        ContactUs.routeName: (_) => ContactUs(),
        CompleteUserInfo.routeName: (_) => CompleteUserInfo(),
        WelcomeScreen.routeName: (_) => WelcomeScreen(),
        AddPic.routeName: (_) => AddPic(),
        InboxScreen.routeName: (_) => InboxScreen(),
        PostDetails.routeName: (_) => PostDetails(),
        ChatScreen.routeName: (_) => ChatScreen(),
      },
    );
  }

  void getValueFromShared() async {
    final prefs = await SharedPreferences.getInstance();
    settingsProvider.changeLanguage(prefs.getString('lang') ?? 'ar');
    if (prefs.getString('theme') == 'light') {
      settingsProvider.changeTheme(ThemeMode.light);
    } else {
      settingsProvider.changeTheme(ThemeMode.dark);
    }
  }
}
