import 'package:find_me_ii/my_theme.dart';
import 'package:find_me_ii/ui/home/home_screen.dart';
import 'package:find_me_ii/ui/registeration/complete_user_info/complete_user_info_viewModel.dart';
import 'package:find_me_ii/validation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:provider/provider.dart';

class CompleteUserInfo extends StatefulWidget {
  static const String routeName = 'Complete User Info';

  @override
  State<CompleteUserInfo> createState() => _CompleteUserInfoState();
}

class _CompleteUserInfoState extends State<CompleteUserInfo>
    implements CompleteUserInfoNavigator {
  late CompleteUserInfoViewModel viewModel;
  var formKey = GlobalKey<FormState>();
  String gov = 'Governorate';

  @override
  void initState() {
    super.initState();
    viewModel = CompleteUserInfoViewModel();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            viewModel.onSkipPrsd();
          },
          child: Text('Skip'),
        ),
        body: Form(
          child: FadeInLeft(
            child: Container(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: MyTheme.secondaryColor,
                                borderRadius: BorderRadius.circular(500)),
                            child: Icon(
                              Icons.person_outlined,
                              size: MediaQuery.of(context).size.height * .15,
                              color: MyTheme.primaryColor,
                            )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .03,
                        ),
                        Text(
                          'Add profile picture',
                          style: TextStyle(color: MyTheme.tertiaryColor),
                        ),
                        Container(
                          color: Colors.black,
                          height: 1,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * .07,
                              vertical:
                                  MediaQuery.of(context).size.height * .025),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .05),
                      decoration: BoxDecoration(
                          color: MyTheme.fourthColor.withOpacity(.08),
                          borderRadius: BorderRadius.circular(12)),
                      child: TextFormField(
                        maxLength: 11,
                        validator: (txt) {
                          if (txt == null || txt.trim().isEmpty) {
                            return null;
                          } else if (!ValidationUtils.isValidPhoneNumber(txt)) {
                            return 'Pleas Enter A Valid Phone Number';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: MyTheme.secondaryColor),
                                borderRadius: BorderRadius.circular(12)),
                            border: InputBorder.none,
                            hintText: 'phone number'),
                      ),
                    ),
                    DropdownButton<String>(
                      items: <String>[
                        'Alexandria',
                        'Ismailia',
                        'Aswan',
                        'Assiut',
                        'Luxor',
                        'Red Sea',
                        'Buhaira',
                        'Beni Suef',
                        'Port Said',
                        'South Sinai',
                        'Giza',
                        'Dakahlia',
                        'Damietta',
                        'Sohag',
                        'Suez',
                        'Sharkia',
                        'North Sinai',
                        'Gharbia',
                        'Fayoum',
                        'Cairo',
                        'Qalyubia',
                        'Qena',
                        'Kafr El Sheikh',
                        'Marsa Matrouh',
                        'Menoufia',
                        'Minya',
                        'New Valley'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text(gov),
                      onChanged: (value) {
                        setState(() {
                          gov = value.toString();
                        });
                      },
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .05),
                      decoration: BoxDecoration(
                          color: MyTheme.fourthColor.withOpacity(.08),
                          borderRadius: BorderRadius.circular(12)),
                      child: TextFormField(
                        maxLines: 3,
                        minLines: 1,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: MyTheme.secondaryColor),
                                borderRadius: BorderRadius.circular(12)),
                            border: InputBorder.none,
                            hintText: 'detailed address'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .05),
                      decoration: BoxDecoration(
                          color: MyTheme.fourthColor.withOpacity(.08),
                          borderRadius: BorderRadius.circular(12)),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: MyTheme.secondaryColor),
                                borderRadius: BorderRadius.circular(12)),
                            border: InputBorder.none,
                            hintText: 'nat ID'),
                      ),
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

  @override
  void goToHome() {
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
}
