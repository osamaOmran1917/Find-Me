import 'package:find_me_ii/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*class ChatBotTab extends StatefulWidget {
  @override
  State<ChatBotTab> createState() => _ChatBotTabState();
}

class _ChatBotTabState extends State<ChatBotTab> implements ChatBotNavigator {
  late ChatBotViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ChatBotViewModel();
    viewModel.navigator = this;
  }

  List<String> messages = [];
  int counter = 0;

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * .015),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              messages.isEmpty ? Text('Empty') : Text('filled'),
              GestureDetector(
                onTap: viewModel.M1,
                child: Container(
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
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: MyTheme.tertiaryColor),
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
                    border: Border.all(width: 1, color: MyTheme.tertiaryColor),
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
        ),
      ),
    );
  }

  @override
  void viewMessages() {
    messages[counter] = 'I wanna add a missing person';
    counter ++;
    setState(() {});
  }
}*/

class ChatBotTab extends StatefulWidget {
  @override
  State<ChatBotTab> createState() => _ChatBotTabState();
}

class _ChatBotTabState extends State<ChatBotTab> {
  List<String> posMessages = [
    'I wanna add a missing person',
    'I wanna search for a missing person',
    'Who\'s chatting with me?'
  ];

  List<String>? messages;

  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .55,
              color: Colors.red.withOpacity(.25),
              child: ListView.builder(
                itemBuilder: (buildContext, index) {
                  return Text(posMessages[index]);
                },
                itemCount: posMessages.length,
              ),
            ),
            Expanded(
              child: Container(),
            ),
            InkWell(
              onTap: () {
                // messages?[counter] = posMessages[0];
                messages?.add('hi');
                // counter ++;
                print(messages?[0]);
              },
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    border:
                        Border.all(width: 1, color: MyTheme.coloredSecondary),
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  AppLocalizations.of(context)!.iWannaAddAMissingPerson,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: MyTheme.coloredSecondary),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
          ],
        ),
      ),
    );
  }
}
