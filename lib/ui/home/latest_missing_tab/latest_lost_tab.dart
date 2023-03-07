import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_me_ii/data_base/missing_person.dart';
import 'package:find_me_ii/data_base/my_database.dart';
import 'package:find_me_ii/helpers/my_theme.dart';
import 'package:find_me_ii/helpers/shared_data.dart';
import 'package:find_me_ii/ui/home/latest_missing_tab/post_details.dart';
import 'package:find_me_ii/ui/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LatestLost extends StatefulWidget {
  @override
  State<LatestLost> createState() => _LatestLostState();
}

class _LatestLostState extends State<LatestLost> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
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
          return ListView.builder(
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
                            arguments: SharedData.missingPerson = data[index]);
                        print(data[index].id);
                      },
                      child: PostWidget(data[index]));
            },
            itemCount: data!.length,
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