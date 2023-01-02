import 'package:find_me_ii/data_base/missing_person.dart';
import 'package:find_me_ii/data_base/my_database.dart';
import 'package:find_me_ii/my_theme.dart';
import 'package:find_me_ii/shared_data.dart';
import 'package:find_me_ii/ui/home/latest_lost_tab/post_details.dart';
import 'package:find_me_ii/ui/home/latest_lost_tab/post_widget.dart';
import 'package:flutter/material.dart';

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
      child: FutureBuilder<List<MissingPerson>>(
        builder: (buildContext, snapshot) {
          if (snapshot.hasError) {
            return Text('Error loading data, try again later.');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: MyTheme.secondaryColor),
            );
          }
          var data = snapshot.data;
          return ListView.builder(
            itemBuilder: (buildContext, index) {
              return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, PostDetails.routeName,
                        arguments: SharedData.missingPerson = data[index]);
                    print(data![index].id);
                  },
                  child: PostWidget(data![index]));
            },
            itemCount: data!.length,
          );
        },
        future: MyDataBase.getAllMissingPersons(),
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
