import 'package:find_me_ii/ui/widgets/chat_user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatsScreen extends StatelessWidget {
  static const String routeName = 'Chat Screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(CupertinoIcons.chat_bubble_2_fill),
        title: const Text('Chat'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add_comment_rounded),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .01),
        physics: BouncingScrollPhysics(),
        itemCount: 16,
        itemBuilder: (context, index) {
          return ChatUserCard();
        },
      ),
    );
  }
}
