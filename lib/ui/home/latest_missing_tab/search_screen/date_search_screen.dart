import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_me_ii/data_base/missing_person.dart';
import 'package:find_me_ii/data_base/my_database.dart';
import 'package:find_me_ii/helpers/my_theme.dart';
import 'package:find_me_ii/helpers/shared_data.dart';
import 'package:find_me_ii/ui/home/latest_missing_tab/post_details.dart';
import 'package:find_me_ii/ui/providers/settings_provider.dart';
import 'package:find_me_ii/ui/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class DateSearchScreen extends StatefulWidget {
  DateTime selectedDate = DateTime.now();

  @override
  State<DateSearchScreen> createState() => _DateSearchScreenState();
}

class _DateSearchScreenState extends State<DateSearchScreen> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final whichDate = ModalRoute.of(context)!.settings.arguments as String;
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return SafeArea(
      child: Scaffold(
          // appBar: AppBar(),
          body: Column(children: [
        CalendarTimeline(
          showYears: true,
          initialDate: widget.selectedDate,
          firstDate: DateTime.now().subtract(Duration(days: 365 * 25 + 6)),
          lastDate: DateTime.now(),
          onDateSelected: (date) {
            if (date == null) return;
            setState(() {
              widget.selectedDate = date;
            });
          },
          leftMargin: 20,
          monthColor: Colors.blueGrey,
          dayColor: Colors.teal[200],
          activeDayColor: Colors.white,
          activeBackgroundDayColor: Colors.redAccent[100],
          dotsColor: Color(0xFF333A47),
          // selectableDayPredicate: (date) => date.day != 23,
          selectableDayPredicate: (date) => true,
          locale: settingsProvider.currentLang,
        ),
        Expanded(
          child: RefreshIndicator(
            key: refreshKey,
            onRefresh: refreshList,
            child: StreamBuilder<QuerySnapshot<MissingPerson>>(
              builder: (buildContext, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(AppLocalizations.of(context)!
                        .errorLoadingDataTryAgainLater),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                        color: MyTheme.coloredSecondary),
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
                                  color: MyTheme.coloredSecondary,
                                  fontSize: 30),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, PostDetails.routeName,
                                  arguments: SharedData.missingPerson =
                                      data[index]);
                              print(data[index].id);
                            },
                            child: PostWidget(data[index]));
                  },
                  itemCount: data!.length,
                );
              },
              // future: MyDataBase.getAllMissingPersons(),
              stream: MyDataBase
                  .listenForMissingPersonsRealTimeUpdatesDependingOnDate(
                      widget.selectedDate),
            ),
          ),
        )
      ])),
    );
  }

  Future<void> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
    return null;
  }
}
