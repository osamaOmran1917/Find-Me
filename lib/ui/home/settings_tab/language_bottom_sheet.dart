import 'package:find_me_ii/my_theme.dart';
import 'package:flutter/material.dart';

class LanguageBottomSheet extends StatefulWidget {
  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      child: Column(
        children: [
          getSelectedItem('English'),
          SizedBox(
            height: MediaQuery.of(context).size.height * .045,
          ),
          getUnSelectedItem('العربية')
        ],
      ),
    );
  }

  Widget getSelectedItem(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(color: MyTheme.tertiaryColor),
        ),
        Icon(
          Icons.check_box_sharp,
          color: MyTheme.tertiaryColor,
        )
      ],
    );
  }

  Widget getUnSelectedItem(String text) {
    return Row(
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.headline5,
        )
      ],
    );
  }
}
