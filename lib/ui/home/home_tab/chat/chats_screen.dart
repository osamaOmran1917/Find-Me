import 'package:find_me_ii/shared_data.dart';
import 'package:flutter/material.dart';

import 'chat_section.dart';

class ChatsScreen extends StatelessWidget {
  static const String routeName = 'Chat Screen';

  @override
  Widget build(BuildContext context) {
    var user = SharedData.user;
    return Scaffold(
      body: ListView(
        children: [
          ChatSection(user!),
          ChatSection(user),
          ChatSection(user!),
          ChatSection(user!),
          ChatSection(user!),
          ChatSection(user!),
          ChatSection(user!),
          ChatSection(user!),
          ChatSection(user!),
          ChatSection(user!),
          ChatSection(user!),
          ChatSection(user!),
          ChatSection(user!),
          ChatSection(user!),
          ChatSection(user!),
          ChatSection(user!),
          ChatSection(user!),
          ChatSection(user!),
          ChatSection(user!),
          ChatSection(user!),
        ],
      ),
    );
  }
}
