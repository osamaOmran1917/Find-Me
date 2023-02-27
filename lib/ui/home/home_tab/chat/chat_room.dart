import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_me_ii/data_base/my_database.dart';
import 'package:find_me_ii/model/my_user.dart';
import 'package:find_me_ii/my_theme.dart';
import 'package:find_me_ii/ui/providers/settings_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ChatRoom extends StatefulWidget {
  final MyUser user;

  const ChatRoom({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    var settingsProvder = Provider.of<SettingsProvider>(context);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: _appBar(),
          ),
          body: Column(children: [
            Expanded(
              child: StreamBuilder(
                  stream: MyDataBase.getAllMessages(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return const Center(child: CircularProgressIndicator());
                      case ConnectionState.active:
                      case ConnectionState.done:
                        final data = snapshot.data?.docs;
                        /*_list =
                            data?.map((e) => MyUser.fromFierStore(e.data()))
                                .toList() ??
                                [];*/
                        final _list = ['Hi', 'Hello'];
                        if (_list.isNotEmpty) {
                          return ListView.builder(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * .01),
                            physics: BouncingScrollPhysics(),
                            itemCount: _list.length,
                            itemBuilder: (context, index) {
                              return Text('Message: ${_list[index]}');
                            },
                          );
                        } else {
                          return Center(
                              child: Text(
                            AppLocalizations.of(context)!.sayHi,
                            style: TextStyle(fontSize: 20),
                          ));
                        }
                    }
                  }),
            ),
            _chatInput(settingsProvder)
          ])),
    );
  }

  Widget _appBar() {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).primaryColor,
              )),
          ClipRRect(
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.height * .3),
            child: CachedNetworkImage(
                width: MediaQuery.of(context).size.height * .05,
                height: MediaQuery.of(context).size.height * .05,
                imageUrl: widget.user.image ?? '',
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => CircleAvatar(
                      child: Icon(CupertinoIcons.person_alt),
                    )),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user.userName ?? 'Find Me User',
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 2),
              Text(
                AppLocalizations.of(context)!.lastSeenNotAvailable,
                style: TextStyle(
                    fontSize: 13, color: Theme.of(context).primaryColor),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _chatInput(SettingsProvider settingsProvider) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * .01,
          horizontal: MediaQuery.of(context).size.width * .025),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * .0400001)),
              child: Row(children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.smiley,
                      color: settingsProvider.isDarkMode()
                          ? MyTheme.coloredTertiary
                          : MyTheme.basicBlack,
                      size: 25,
                    )),
                Expanded(
                    child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: 'type a message...', border: InputBorder.none),
                )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.photo_on_rectangle,
                      color: settingsProvider.isDarkMode()
                          ? MyTheme.coloredTertiary
                          : MyTheme.basicBlack,
                      size: 26,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.camera,
                      color: settingsProvider.isDarkMode()
                          ? MyTheme.coloredTertiary
                          : MyTheme.basicBlack,
                      size: 26,
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .02,
                )
              ]),
            ),
          ),
          MaterialButton(
            onPressed: () {},
            minWidth: 0,
            shape: CircleBorder(),
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
            color: settingsProvider.isDarkMode()
                ? MyTheme.coloredSecondary
                : MyTheme.basicBlue,
            child: Icon(
              Icons.send,
              color: settingsProvider.isDarkMode()
                  ? MyTheme.coloredTertiary
                  : MyTheme.basicWhite,
              size: 28,
            ),
          )
        ],
      ),
    );
  }
}
