import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_me_ii/data_base/my_database.dart';
import 'package:find_me_ii/helpers/date_utils.dart';
import 'package:find_me_ii/helpers/dialog_utils.dart';
import 'package:find_me_ii/helpers/shared_data.dart';
import 'package:find_me_ii/model/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({Key? key, required this.message}) : super(key: key);

  final Message message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    bool isMe = SharedData.user?.id == widget.message.fromId ||
        MyDataBase.user.uid == widget.message.fromId;
    return InkWell(
        onLongPress: () {
          _showBottomSheet(isMe);
        },
        child: isMe ? _greenMessage() : _blueMessage());
  }

  Widget _blueMessage() {
    if (widget.message.read.isEmpty) {
      MyDataBase.updateMessageReadStatus(widget.message);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.lightBlue),
                color: Color.fromARGB(255, 221, 245, 255),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            padding: EdgeInsets.all(widget.message.type == Type.image
                ? MediaQuery.of(context).size.width * .03
                : MediaQuery.of(context).size.width * .04),
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .04,
                vertical: MediaQuery.of(context).size.height * .01),
            child: widget.message.type == Type.text
                ? Text(
              widget.message.msg,
              style: TextStyle(fontSize: 15, color: Colors.black87),
            )
                : ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                  imageUrl: widget.message.msg,
                  placeholder: (context, url) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    CupertinoIcons.photo_fill_on_rectangle_fill,
                    size: 70,
                  )),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .04),
          child: Text(
              getFormattedTime(context: context, time: widget.message.sent),
              style: TextStyle(fontSize: 13, color: Colors.black54)),
        ),
      ],
    );
  }

  Widget _greenMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .04,
            ),
            if (widget.message.read.isNotEmpty)
              Icon(
                Icons.done_all_rounded,
                color: Colors.blue,
                size: 20,
              ),
            SizedBox(
              width: 2,
            ),
            Text(getFormattedTime(context: context, time: widget.message.sent),
                style: TextStyle(fontSize: 13, color: Colors.black54)),
          ],
        ),
        Flexible(
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightGreen),
                  color: Color.fromARGB(255, 218, 255, 176),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30))),
              padding: EdgeInsets.all(widget.message.type == Type.image
                  ? MediaQuery.of(context).size.width * .03
                  : MediaQuery.of(context).size.width * .04),
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .04,
                  vertical: MediaQuery.of(context).size.height * .01),
              child: widget.message.type == Type.text
                  ? Text(
                widget.message.msg,
                style: TextStyle(fontSize: 15, color: Colors.black87),
              )
                  : ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                    imageUrl: widget.message.msg,
                    placeholder: (context, url) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(
                      CupertinoIcons.photo_fill_on_rectangle_fill,
                      size: 70,
                    )),
              )),
        )
      ],
    );
  }

  void _showBottomSheet(bool isMe) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8)),
                  height: 4,
                  margin: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * .015,
                      horizontal: MediaQuery.of(context).size.width * .4)),
              widget.message.type == Type.text
                  ? _OptionItem(
                      icon: Icon(
                        Icons.copy_all_rounded,
                        color: Colors.blue,
                        size: 26,
                      ),
                      name: 'copy text',
                      onTap: () async {
                        await Clipboard.setData(
                                ClipboardData(text: widget.message.msg))
                            .then((value) {
                          Navigator.pop(context);
                        });
                      })
                  : _OptionItem(
                      icon: ImageIcon(AssetImage('assets/images/image-.png')),
                      name: 'save image',
                      onTap: () async {
                        try {
                          await GallerySaver.saveImage(widget.message.msg,
                                  albumName: 'Find Me')
                              .then((success) {
                            Navigator.pop(context);
                            if (success != null && success)
                              Dialogs.showSnackbar(
                                  context, 'Saved To Gallery!');
                          });
                        } catch (e) {
                          log('Error While Saving Image $e');
                        }
                      }),
              if (isMe)
                Divider(
                  color: Colors.black54,
                  endIndent: MediaQuery.of(context).size.width * .04,
                  indent: MediaQuery.of(context).size.width * .04,
                ),
              if (widget.message.type == Type.text && isMe)
                _OptionItem(
                    icon: ImageIcon(
                      AssetImage('assets/images/edit.png'),
                      color: Colors.blue,
                    ),
                    name: 'edit message',
                    onTap: () {
                      Navigator.pop(context);
                      _showMessageUpdateDialog();
                    }),
              if (isMe)
                _OptionItem(
                    icon: Icon(
                      CupertinoIcons.delete,
                      color: Colors.red,
                      size: 26,
                    ),
                    name: 'delete message',
                    onTap: () async {
                      await MyDataBase.deleteMessage(widget.message)
                          .then((value) {
                        Navigator.pop(context);
                      });
                    }),
              Divider(
                color: Colors.black54,
                endIndent: MediaQuery.of(context).size.width * .04,
                indent: MediaQuery.of(context).size.width * .04,
              ),
              _OptionItem(
                  icon: ImageIcon(
                    AssetImage('assets/images/sent.png'),
                    color: Colors.blue,
                  ),
                  name:
                      'sent at    ${getMessageTime(context: context, time: widget.message.sent)}',
                  onTap: () {}),
              _OptionItem(
                  icon: ImageIcon(
                    AssetImage('assets/images/eyes.png'),
                    color: Colors.green,
                  ),
                  name: widget.message.read.isEmpty
                      ? 'not seen yet'
                      : 'read at    ${getMessageTime(context: context, time: widget.message.read)}',
                  onTap: () {})
            ],
          );
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))));
  }

  void _showMessageUpdateDialog() {
    String updatedMessage = widget.message.msg;
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Row(children: [
                Icon(CupertinoIcons.text_bubble, color: Colors.blue, size: 28),
                Text('  update message')
              ]),
              content: TextFormField(
                  initialValue: updatedMessage,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)))),
              actions: [],
            ));
  }
}

class _OptionItem extends StatelessWidget {
  final Widget icon;
  final String name;
  final VoidCallback onTap;

  const _OptionItem({required this.icon, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * .05,
            right: MediaQuery.of(context).size.width * .05,
            top: MediaQuery.of(context).size.height * .015,
            bottom: MediaQuery.of(context).size.height * .015),
        child: Row(
          children: [
            icon,
            Flexible(
                child: Text(
              '    $name',
              style: TextStyle(
                  fontSize: 15, color: Colors.black54, letterSpacing: .5),
            ))
          ],
        ),
      ),
    );
  }
}
