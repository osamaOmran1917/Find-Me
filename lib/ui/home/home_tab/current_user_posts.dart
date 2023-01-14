import 'package:flutter/material.dart';

class CurrentUserPosts extends StatelessWidget {
  static const String routeName = 'Current User Posts';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your posts'),
      ),
    );
  }
}
