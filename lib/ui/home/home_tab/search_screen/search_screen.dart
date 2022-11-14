import 'package:find_me_ii/my_theme.dart';
import 'package:flutter/material.dart';

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
              color: MyTheme.tertiaryColor,
              borderRadius: BorderRadius.circular(40)),
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Age'),
              ),
              TextFormField(
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(
                    labelText: 'Describe the person you are \n searching for'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Text('Add photos'), Icon(Icons.add_a_photo)],
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    )),
                    backgroundColor:
                        MaterialStateProperty.all(MyTheme.secondaryColor),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Search'),
                      Icon(Icons.search),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
