import 'package:find_me_ii/data_base/my_database.dart';
import 'package:find_me_ii/date_utils.dart';
import 'package:find_me_ii/model/message.dart';
import 'package:find_me_ii/shared_data.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({Key? key, required this.message}) : super(key: key);

  final Message message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return SharedData.user?.id == widget.message.fromId ||
            MyDataBase.user.uid == widget.message.fromId
        ? _greenMessage()
        : _blueMessage();
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
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * .04),
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .04,
                  vertical: MediaQuery.of(context).size.height * .01),
              child: Text(
                widget.message.msg,
                style: TextStyle(fontSize: 15, color: Colors.black87),
              )),
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
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * .04),
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .04,
                  vertical: MediaQuery.of(context).size.height * .01),
              child: Text(
                widget.message.msg,
                style: TextStyle(fontSize: 15, color: Colors.black87),
              )),
        )
      ],
    );
  }
}
