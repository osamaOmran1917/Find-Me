import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:find_me_ii/data_base/my_database.dart';
import 'package:find_me_ii/helpers/date_utils.dart';
import 'package:find_me_ii/helpers/my_theme.dart';
import 'package:find_me_ii/model/message.dart';
import 'package:find_me_ii/model/my_user.dart';
import 'package:find_me_ii/ui/home/view_profile_screen.dart';
import 'package:find_me_ii/ui/providers/settings_provider.dart';
import 'package:find_me_ii/ui/widgets/message_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ChatRoom extends StatefulWidget {
  final MyUser user;

  const ChatRoom({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  List<Message> _list = [];

  final _textController = TextEditingController();
  bool _showEmoji = false, _isUploading = false;

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () {
            if (_showEmoji) {
              setState(() {
                _showEmoji = !_showEmoji;
              });
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          },
          child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                flexibleSpace: _appBar(),
              ),
              backgroundColor: Color.fromARGB(255, 234, 248, 255),
              body: Column(children: [
                Expanded(
                  child: StreamBuilder(
                      stream: MyDataBase.getAllMessages(widget.user),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                          case ConnectionState.none:
                            return const SizedBox();
                          case ConnectionState.active:
                          case ConnectionState.done:
                            final data = snapshot.data?.docs;
                            _list = data
                                    ?.map((e) => Message.fromJson(e.data()))
                                    .toList() ??
                                [];
                            if (_list.isNotEmpty) {
                              return ListView.builder(
                                reverse: true,
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        .01),
                                physics: BouncingScrollPhysics(),
                                itemCount: _list.length,
                                itemBuilder: (context, index) {
                                  return MessageCard(
                                    message: _list[index],
                                  );
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
                if (_isUploading)
                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )),
                _chatInput(settingsProvider),
                if (_showEmoji)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .35,
                    child: EmojiPicker(
                      onBackspacePressed: () {},
                      textEditingController: _textController,
                      // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
                      config: Config(
                        bgColor: Color.fromARGB(255, 234, 248, 255),
                        columns: 8,
                        emojiSizeMax: 32 *
                            (Platform.isIOS
                                ? 1.30
                                : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
                      ),
                    ),
                  )
              ])),
        ),
      ),
    );
  }

  Widget _appBar() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ViewProfileScreen(user: widget.user)));
      },
      child: StreamBuilder(
        stream: MyDataBase.getUserInfo(widget.user),
        builder: (context, snapshot) {
          final data = snapshot.data?.docs;
          final list =
              data?.map((e) => MyUser.fromFierStore(e.data())).toList() ?? [];
          return Row(
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
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.height * .3),
                child: CachedNetworkImage(
                    width: MediaQuery.of(context).size.height * .05,
                    height: MediaQuery.of(context).size.height * .05,
                    imageUrl:
                        (list.isNotEmpty ? list[0].image : widget.user.image) ??
                            '',
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
                    (list.isNotEmpty
                            ? list[0].userName
                            : widget.user.userName) ??
                        AppLocalizations.of(context)!.findMeUser,
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 2),
                  Text(
                    (list.isNotEmpty
                            ? (list[0].is_online ?? false)
                                ? 'online'
                                : getLastActiveTime(
                                    context: context,
                                    lastActive: list[0].last_active ?? '')
                            : getLastActiveTime(
                                context: context,
                                lastActive: widget.user.last_active ?? '')) ??
                        AppLocalizations.of(context)!.lastSeenNotAvailable,
                    style: TextStyle(
                        fontSize: 13, color: Theme.of(context).primaryColor),
                  )
                ],
              )
            ],
          );
        },
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
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      setState(() => _showEmoji = !_showEmoji);
                    },
                    icon: Icon(
                      CupertinoIcons.smiley,
                      color: settingsProvider.isDarkMode()
                          ? MyTheme.coloredTertiary
                          : MyTheme.basicBlack,
                      size: 25,
                    )),
                Expanded(
                    child: TextField(
                      controller: _textController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  onTap: () {
                    if (_showEmoji) setState(() => _showEmoji = !_showEmoji);
                  },
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.typeAMessage,
                      border: InputBorder.none),
                )),
                IconButton(
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      final List<XFile> images =
                          await picker.pickMultiImage(imageQuality: 70);
                      for (var i in images) {
                        setState(() => _isUploading = true);
                        await MyDataBase.sendChatImage(
                            widget.user, File(i.path));
                        setState(() => _isUploading = false);
                      }
                    },
                    icon: Icon(
                      CupertinoIcons.photo_on_rectangle,
                      color: settingsProvider.isDarkMode()
                          ? MyTheme.coloredTertiary
                          : MyTheme.basicBlack,
                      size: 26,
                    )),
                IconButton(
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image = await picker.pickImage(
                          source: ImageSource.camera, imageQuality: 70);
                      if (image != null) {
                        setState(() => _isUploading = true);
                        await MyDataBase.sendChatImage(
                            widget.user, File(image.path));
                        setState(() => _isUploading = false);
                      }
                    },
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
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                MyDataBase.sendMessage(
                    widget.user, _textController.text, Type.text);
                _textController.text = '';
              }
            },
            minWidth: 0,
            shape: CircleBorder(),
            padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
                right: settingsProvider.isArabic() ? 10 : 5,
                left: settingsProvider.isArabic() ? 5 : 10),
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