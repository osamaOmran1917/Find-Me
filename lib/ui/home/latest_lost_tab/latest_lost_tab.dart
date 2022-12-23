import 'package:find_me_ii/ui/home/latest_lost_tab/news_widget.dart';
import 'package:flutter/material.dart';

class LatestLost extends StatelessWidget {
  List<NewsWidget> lost = [
    NewsWidget(),
    NewsWidget(),
    NewsWidget(),
    NewsWidget(),
    NewsWidget(),
    NewsWidget()
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: lost.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              lost[index],
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              )
            ],
          );
        });
  }
}
