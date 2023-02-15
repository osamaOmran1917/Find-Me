import 'package:cached_network_image/cached_network_image.dart';
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
        leading: ClipRRect(
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.height * .3),
          child: CachedNetworkImage(
              width: MediaQuery.of(context).size.height * .055,
              height: MediaQuery.of(context).size.height * .055,
              imageUrl: widget.user.image ?? '',
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => CircleAvatar(
                    child: Icon(CupertinoIcons.person_alt),
                  )),
        ),
        title: Text(widget.user.userName ?? ''),
        subtitle: Text(
          widget.user.id ?? '',
          maxLines: 1,
        ),
        /*trailing: Text(
          '12:00 PM',
          style: TextStyle(color: Colors.black54),
        ),*/
        trailing: Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
              color: Colors.greenAccent.shade400,
              borderRadius: BorderRadius.circular(10)),
        ),
      )),
    );
  }
}
