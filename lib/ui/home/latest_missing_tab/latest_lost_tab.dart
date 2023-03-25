import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_me_ii/data_base/missing_person.dart';
import 'package:find_me_ii/data_base/my_database.dart';
import 'package:find_me_ii/helpers/my_theme.dart';
import 'package:find_me_ii/helpers/shared_data.dart';
import 'package:find_me_ii/ui/home/latest_missing_tab/post_details.dart';
import 'package:find_me_ii/ui/providers/settings_provider.dart';
import 'package:find_me_ii/ui/widgets/post_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LatestLost extends StatefulWidget {
  @override
  State<LatestLost> createState() => _LatestLostState();
}

class _LatestLostState extends State<LatestLost> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  ScrollController listScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return RefreshIndicator(
      key: refreshKey,
      onRefresh: refreshList,
      child: StreamBuilder<QuerySnapshot<MissingPerson>>(
        builder: (buildContext, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  AppLocalizations.of(context)!.errorLoadingDataTryAgainLater),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: MyTheme.coloredSecondary),
            );
          }
          var data = snapshot.data?.docs.map((e) => e.data()).toList();
          all = data ?? [];
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: settingsProvider.isDarkMode()
                  ? MyTheme.coloredTertiary
                  : MyTheme.basicBlack,
              onPressed: () {
                if (listScrollController.hasClients) {
                  final position =
                      listScrollController.position.minScrollExtent;
                  listScrollController.animateTo(
                    position,
                    duration: Duration(seconds: 1),
                    curve: Curves.easeOut,
                  );
                }
              },
              isExtended: true,
              tooltip: "Scroll to Top",
              child: Icon(CupertinoIcons.arrow_up),
            ),
            body: ListView.builder(
              controller: listScrollController,
              physics: BouncingScrollPhysics(),
              itemBuilder: (buildContext, index) {
                return data.isEmpty
                    ? Center(
                        child: Text(
                          AppLocalizations.of(context)!.noLostPeople,
                          style: TextStyle(
                              color: MyTheme.coloredSecondary, fontSize: 30),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, PostDetails.routeName,
                              arguments: SharedData.missingPerson =
                                  data[index]);
                          print(data[index].id);
                        },
                        child: PostWidget(data[index]));
              },
              itemCount: data!.length,
            ),
          );
        },
        // future: MyDataBase.getAllMissingPersons(),
        stream: MyDataBase.listenForMissingPersonsRealTimeUpdates(),
      ),
    );
  }

  Future<void> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
    return null;
  }
}

late List<MissingPerson> all;