import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_me_ii/model/my_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatRoom extends StatefulWidget {
  final MyUser user;

  const ChatRoom({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: _appBar(),
        ),
      ),
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
}
