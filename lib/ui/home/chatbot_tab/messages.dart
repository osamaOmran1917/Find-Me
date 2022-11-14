import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  String? message;

  Message(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Text(message ?? ''),
    );
  }
}