import 'package:find_me_ii/my_theme.dart';
import 'package:find_me_ii/ui/home/home_tab/search_screen/date_search_screen.dart';
import 'package:find_me_ii/ui/home/home_tab/search_screen/text_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = 'Search Screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.coloredSecondary,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * .8,
          height: MediaQuery.of(context).size.height * .8,
          decoration: BoxDecoration(
              color: MyTheme.basicWhite,
              borderRadius: BorderRadius.circular(40)),
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  /*showSearch(
                      context: context, delegate: PersonSearchDelegate());*/
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => TextSearchScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.textSearch,
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
                          side: BorderSide(color: MyTheme.basicBlue))),
                  backgroundColor:
                      MaterialStateProperty.all(MyTheme.coloredSecondary),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => DateSearchScreen(),
                          settings: RouteSettings(arguments: 'post')));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.searchByPostDate,
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
                          side: BorderSide(color: MyTheme.basicBlue))),
                  backgroundColor:
                      MaterialStateProperty.all(MyTheme.coloredSecondary),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => DateSearchScreen(),
                          settings: RouteSettings(arguments: 'lose')));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.searchByDateOfLose,
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
                          side: BorderSide(color: MyTheme.basicBlue))),
                  backgroundColor:
                      MaterialStateProperty.all(MyTheme.coloredSecondary),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => DateSearchScreen(),
                          settings: RouteSettings(arguments: 'finding')));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.searchByDateOfFinding,
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
                          side: BorderSide(color: MyTheme.basicBlue))),
                  backgroundColor:
                      MaterialStateProperty.all(MyTheme.coloredSecondary),
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
                      AppLocalizations.of(context)!.searchByPhoto,
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
                          side: BorderSide(color: MyTheme.basicBlue))),
                  backgroundColor:
                      MaterialStateProperty.all(MyTheme.coloredSecondary),
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

// class PersonSearchDelegate extends SearchDelegate {
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//           onPressed: () {
//             showResults(context);
//           },
//           icon: Icon(Icons.search))
//     ];
//   }
//
//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         icon: Icon(Icons.clear));
//   }
//
//   /*@override
//   Widget buildResults(BuildContext context) {
//     return FutureBuilder<List<MissingPerson>>(
//       builder: (buildContext, snapshot) {
//         if (snapshot.hasError) {
//           return Text(
//               AppLocalizations.of(context)!.errorLoadingDataTryAgainLater);
//         } else if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(color: MyTheme.coloredSecondary),
//           );
//         }
//         var data = snapshot.data;
//         return ListView.builder(
//           physics: BouncingScrollPhysics(),
//           itemBuilder: (buildContext, index) {
//             return data.isEmpty
//                 ? Center(
//                     child: Text(
//                       AppLocalizations.of(context)!.noLostPeople,
//                       style: TextStyle(
//                           color: MyTheme.coloredSecondary, fontSize: 30),
//                     ),
//                   )
//                 : !(data[index].name!.contains(query) ||
//                         data[index].adress!.contains(query) ||
//                 data[index].gov!.contains(query) ||
//                 data[index].desc!.contains(query) ||
//                 data[index].age! == query)
//                 ? Container()
//                 : InkWell(
//                 onTap: () {
//                   Navigator.pushNamed(context, PostDetails.routeName,
//                       arguments: SharedData.missingPerson =
//                       data[index]);
//                   print(data![index].id);
//                 },
//                 child: PostWidget(data![index]));
//           },
//           itemCount: data!.length,
//         );
//       },
//       future: MyDataBase.getAllMissingPersons(),
//     );
//   }*/
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return Center(child: Text(AppLocalizations.of(context)!.suggestions));
//   }
// }
