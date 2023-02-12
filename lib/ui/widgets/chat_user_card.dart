import 'package:find_me_ii/model/my_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatUserCard extends StatefulWidget {
  final MyUser user;

  const ChatUserCard({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .04, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: .5,
      child: InkWell(
          child: ListTile(
            leading: CircleAvatar(
          child: Icon(CupertinoIcons.person_alt),
        ),
        title: Text(widget.user.userName ?? ''),
        subtitle: Text(
          widget.user.id ?? '',
          maxLines: 1,
        ),
        trailing: Text(
          '12:00 PM',
          style: TextStyle(color: Colors.black54),
        ),
      )),
    );
  }
}
