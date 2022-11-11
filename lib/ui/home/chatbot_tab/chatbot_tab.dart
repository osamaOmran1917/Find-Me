import 'package:find_me_ii/my_theme.dart';
import 'package:flutter/material.dart';

class ChatBotTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .015),
        width: double.infinity,
        child: Column(
          children: [
            Column(
              children: [],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: MyTheme.tertiaryColor),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    'I wanna add a missing person',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: MyTheme.tertiaryColor),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: MyTheme.tertiaryColor),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    'I wanna search for a missing person',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: MyTheme.tertiaryColor),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: MyTheme.tertiaryColor),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    'Who\'s chatting with me?',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: MyTheme.tertiaryColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
