import 'package:find_me_ii/base/base.dart';
import 'package:find_me_ii/my_theme.dart';
import 'package:find_me_ii/ui/home/home_tab/home_tab_viewModel.dart';
import 'package:find_me_ii/ui/home/home_tab/search_screen/search_screen.dart';
import 'package:flutter/material.dart';

import 'insert_lost_person_screen/insert_lost_person_screen.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends BaseState<HomeTab, HomeTabViewModel>
    implements HomeTabNavigator {
  @override
  HomeTabViewModel initViewModel() {
    return HomeTabViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => onFindPersonPressed(),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 26),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25))),
                child: Row(
                  children: [
                    Text(
                      'Find lost person',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .06,
                    ),
                    Icon(
                      Icons.person_search,
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .1,
        ),
        InkWell(
          onTap: () => onInsertMissingPersonPressed(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 26),
                decoration: BoxDecoration(
                    border: Border.all(color: MyTheme.secondaryColor, width: 3),
                    color: MyTheme.primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        bottomLeft: Radius.circular(25))),
                child: Row(
                  children: [
                    Icon(
                      Icons.person_add,
                      color: MyTheme.secondaryColor,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .06,
                    ),
                    Text(
                      'Insert found person',
                      style: TextStyle(
                          color: MyTheme.secondaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .1,
        ),
        InkWell(
          onTap: () => onFindPersonPressed(),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 26),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25))),
                child: Row(
                  children: [
                    Text(
                      'Insert lost person',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .06,
                    ),
                    Icon(
                      Icons.person_off,
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  void onFindPersonPressed() {
    viewModel.onFindPersonClicked();
  }

  void onInsertMissingPersonPressed() {
    viewModel.onInsertMissingPersonClicked();
  }

  @override
  void goToSearchScreen() {
    Navigator.pushNamed(context, SearchScreen.routeName);
  }

  @override
  void goToInsertMissingPersonScreen() {
    Navigator.pushNamed(context, InsertLostPersonScreen.routeName);
  }
}
