import 'package:flutter/material.dart';

class LogInScreen extends StatelessWidget {
  static const String routeName = 'LogIn Screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * .05),
        child: AppBar(
          centerTitle: true,
          title: Text('Find Me'),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              TextField(),
              TextField(),
            ],
          )),
    );
  }
}
