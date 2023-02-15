import 'package:find_me_ii/data_base/my_database.dart';
import 'package:find_me_ii/model/my_user.dart';
import 'package:find_me_ii/ui/widgets/chat_user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatsScreen extends StatelessWidget {
  static const String routeName = 'Chat Screen';
  List<MyUser> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(CupertinoIcons.chat_bubble_2_fill),
        title: const Text('Chat'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.search)),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add_comment_rounded),
        ),
      ),
      body: StreamBuilder(
          stream: MyDataBase.firestore.collection('Users').snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.active:
              case ConnectionState.done:
                final data = snapshot.data?.docs;
                list =
                    data?.map((e) => MyUser.fromFierStore(e.data())).toList() ??
                        [];
                if (list.isNotEmpty) {
                  return ListView.builder(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .01),
                    physics: BouncingScrollPhysics(),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return ChatUserCard(user: list[index]);
                    },
                  );
                } else {
                  return Center(
                      child: Text(
                    'No Connections Found!',
                    style: TextStyle(fontSize: 20),
                  ));
                }
            }
          }),
    );
  }
}
