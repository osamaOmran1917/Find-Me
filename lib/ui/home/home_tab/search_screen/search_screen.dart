import 'package:find_me_ii/data_base/missing_person.dart';
import 'package:find_me_ii/my_theme.dart';
import 'package:flutter/material.dart';

import '../../../../data_base/my_database.dart';
import '../../../../shared_data.dart';
import '../../latest_lost_tab/post_details.dart';
import '../../latest_lost_tab/post_widget.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = 'Search Screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.secondaryColor,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * .8,
          height: MediaQuery.of(context).size.height * .8,
          decoration: BoxDecoration(
              color: MyTheme.primaryColor,
              borderRadius: BorderRadius.circular(40)),
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  showSearch(
                      context: context, delegate: PersonSearchDelegate());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Text search',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .03),
                    ),
                    Icon(Icons.search)
                  ],
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: MyTheme.tertiaryColor))),
                  backgroundColor:
                      MaterialStateProperty.all(MyTheme.secondaryColor),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Search by date of lose',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .03),
                    ),
                    Icon(Icons.search)
                  ],
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: MyTheme.tertiaryColor))),
                  backgroundColor:
                      MaterialStateProperty.all(MyTheme.secondaryColor),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Search by date of finding',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .03),
                    ),
                    Icon(Icons.search)
                  ],
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: MyTheme.tertiaryColor))),
                  backgroundColor:
                      MaterialStateProperty.all(MyTheme.secondaryColor),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Search by photo',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .03),
                    ),
                    Icon(Icons.search)
                  ],
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: MyTheme.tertiaryColor))),
                  backgroundColor:
                      MaterialStateProperty.all(MyTheme.secondaryColor),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PersonSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            showResults(context);
          },
          icon: Icon(Icons.search))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.clear));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<MissingPerson>>(
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
            return data.isEmpty
                ? Center(
                    child: Text(
                      'No Lost People',
                      style: TextStyle(
                          color: MyTheme.secondaryColor, fontSize: 30),
                    ),
                  )
                : !(data[index].name!.contains(query) ||
                        data[index].adress!.contains(query) ||
                        data[index].gov!.contains(query) ||
                        data[index].desc!.contains(query) ||
                        data[index].age! == query)
                    ? Container()
                    : InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, PostDetails.routeName,
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text('Suggestions...'));
  }
}
