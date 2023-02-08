import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatUserCard extends StatefulWidget {
  const ChatUserCard({Key? key}) : super(key: key);

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
        title: Text('Demo User'),
        subtitle: Text(
          'last user message',
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
