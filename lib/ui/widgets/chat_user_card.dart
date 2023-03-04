import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_me_ii/data_base/my_database.dart';
import 'package:find_me_ii/date_utils.dart';
import 'package:find_me_ii/model/message.dart';
import 'package:find_me_ii/model/my_user.dart';
import 'package:find_me_ii/shared_data.dart';
import 'package:find_me_ii/ui/home/home_tab/chat/chat_room.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatUserCard extends StatefulWidget {
  final MyUser user;

  const ChatUserCard({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  Message? _message;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .04, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: .5,
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ChatRoom(
                          user: widget.user,
                        )));
          },
          child: StreamBuilder(
              stream: MyDataBase.getLastMessage(widget.user),
              builder: (context, snapshot) {
                final data = snapshot.data?.docs;
                final list =
                    data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
                if (list.isNotEmpty) _message = list[0];
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height * .3),
                    child: CachedNetworkImage(
                        width: MediaQuery.of(context).size.height * .055,
                        height: MediaQuery.of(context).size.height * .055,
                        imageUrl: widget.user.image ?? '',
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => CircleAvatar(
                              child: Icon(CupertinoIcons.person_alt),
                            )),
                  ),
                  title: Text(widget.user.userName ?? ''),
                  subtitle: Text(
                    _message != null
                        ? _message!.type == Type.image
                            ? 'image'
                            : _message!.msg
                        : widget.user.email ?? '',
                    maxLines: 1,
                  ),
                  /*trailing: Text(
          '12:00 PM',
          style: TextStyle(color: Colors.black54),
        ),*/
                  trailing: _message == null
                      ? null
                      : _message!.read.isEmpty &&
                              _message!.fromId != MyDataBase.user.uid &&
                              _message!.fromId != SharedData.user?.id
                          ? Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                  color: Colors.greenAccent.shade400,
                                  borderRadius: BorderRadius.circular(10)),
                            )
                          : Text(
                              getLastMessageTime(
                                  context: context, time: _message!.sent),
                              style: TextStyle(color: Colors.black45),
                            ),
                );
              })),
    );
  }
}
