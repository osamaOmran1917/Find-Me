import 'package:find_me_ii/shared_data.dart';
import 'package:find_me_ii/ui/home/latest_lost_tab/post_widget.dart';
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
