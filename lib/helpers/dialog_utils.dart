import 'package:find_me_ii/helpers/my_theme.dart';
import 'package:flutter/material.dart';

void showMessage(BuildContext context, String message,
    {String? posActionName,
    VoidCallback? posAction,
    String? negActionName,
    VoidCallback? negAction,
    bool isCancelable = true}) {
  List<Widget> actions = [];
  if (posActionName != null) {
    actions.add(TextButton(
        onPressed: () {
          Navigator.pop(context);
          if (posAction != null) posAction();
        },
        child: Text(posActionName, style: TextStyle(fontFamily: 'Arabic'))));
  }

  if (negActionName != null) {
    actions.add(TextButton(
        onPressed: () {
          Navigator.pop(context);
          if (negAction != null) negAction();
        },
        child: Text(negActionName, style: TextStyle(fontFamily: 'Arabic'))));
  }

  showDialog(
      context: context,
      builder: (buildContext) {
        return AlertDialog(
            content: Text(
              message,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontFamily: 'Arabic'),
            ),
            actions: actions);
      },
      barrierDismissible: isCancelable);
}

void showWidget(BuildContext context, Widget widget,
    {String? posActionName,
    VoidCallback? posAction,
    String? negActionName,
    VoidCallback? negAction,
    bool isCancelable = true}) {
  List<Widget> actions = [];
  if (posActionName != null) {
    actions.add(TextButton(
        onPressed: () {
          Navigator.pop(context);
          if (posAction != null) posAction();
        },
        child: Text(posActionName, style: TextStyle(fontFamily: 'Arabic'))));
  }

  if (negActionName != null) {
    actions.add(TextButton(
        onPressed: () {
          Navigator.pop(context);
          if (negAction != null) negAction();
        },
        child: Text(negActionName, style: TextStyle(fontFamily: 'Arabic'))));
  }

  showDialog(
      context: context,
      builder: (buildContext) {
        return AlertDialog(content: widget, actions: actions);
      },
      barrierDismissible: isCancelable);
}

void showLoading(BuildContext context, String loadingMessage,
    {bool isCancelable = true}) {
  showDialog(
      context: context,
      builder: (BuildContext) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(
                color: MyTheme.coloredSecondary,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                loadingMessage,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontFamily: 'Arabic'),
              )
            ],
          ),
        );
      },
      barrierDismissible: isCancelable);
}

void hideLoading(BuildContext context) {
  Navigator.pop(context);
}

class Dialogs {
  static void showSnackbar(BuildContext context, String msg) {
    // var settingsProvider = Provider.of<SettingsProvider>(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: TextStyle(fontFamily: 'Arabic')),
      behavior: SnackBarBehavior.floating,
    ));
  }

  static void showProgressBar(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
  }
}
