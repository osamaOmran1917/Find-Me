import 'package:find_me_ii/data_base/missing_person.dart';
import 'package:find_me_ii/data_base/my_database.dart';
import 'package:find_me_ii/my_theme.dart';
import 'package:find_me_ii/shared_data.dart';
import 'package:find_me_ii/ui/home/home_tab/post_details.dart';
import 'package:find_me_ii/ui/widgets/post_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TextSearchScreen extends StatefulWidget {
  @override
  State<TextSearchScreen> createState() => _TextSearchScreenState();
}

class _TextSearchScreenState extends State<TextSearchScreen> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  TextEditingController searchController = TextEditingController();
  bool showResult = false;

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(CupertinoIcons.search),
        onPressed: () {
          if (searchController.text == null ||
              searchController.text.trim().isEmpty)
            return;
          else
            setState(() {
              showResult = true;
            });
        },
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          width: mq.width * .8,
          height: mq.height * .1,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(mq.width * .5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                onChanged: (text) {
                  if (text.trim().isNotEmpty || text == null)
                    setState(() {
                      showResult = false;
                    });
                },
                controller: searchController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(CupertinoIcons.search_circle),
                  ),
                  prefixIcon: IconButton(
                    onPressed: () {
                      searchController.clear();
                    },
                    icon: Icon(CupertinoIcons.clear_circled),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(mq.width * .5)),
                  hintText: 'Search',
                ),
              ),
            ],
          ),
        ),
      ),
      body: showResult
          ? RefreshIndicator(
              key: refreshKey,
              onRefresh: refreshList,
              child: FutureBuilder<List<MissingPerson>>(
                builder: (buildContext, snapshot) {
                  if (snapshot.hasError) {
                    return Text(AppLocalizations.of(context)!
                        .errorLoadingDataTryAgainLater);
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                          color: MyTheme.coloredSecondary),
                    );
                  }

                  var data = snapshot.data;
                  return ListView.builder(
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
                          : !(data[index]
                                      .name!
                                      .contains(searchController.text) ||
                                  data[index]
                                      .adress!
                                      .contains(searchController.text) ||
                                  data[index]
                                      .gov!
                                      .contains(searchController.text) ||
                                  data[index]
                                      .desc!
                                      .contains(searchController.text) ||
                                  data[index].age! == searchController.text)
                              ? Container()
                              : InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, PostDetails.routeName,
                                        arguments: SharedData.missingPerson =
                                            data[index]);
                                    print(data![index].id);
                                  },
                                  child: PostWidget(data![index]));
                    },
                    itemCount: data!.length,
                  );
                },
                future: MyDataBase.getAllMissingPersons(),
              ),
            )
          : null,
    );
  }

  Future<void> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
    return null;
  }
}
