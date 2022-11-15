import 'package:find_me_ii/my_theme.dart';
import 'package:flutter/material.dart';

class PickImageBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color: MyTheme.primaryColor,
      ),
      height: MediaQuery.of(context).size.height * .17,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              capture(context);
            },
            child: Image.asset(
              'assets/images/camera.png',
              width: 50,
              height: 50,
            ),
          ),
          InkWell(
            onTap: () {
              pickFromGallery(context);
            },
            child: Image.asset(
              'assets/images/picture.png',
              width: 50,
              height: 50,
            ),
          ),
        ],
      ),
    );
  }

  Future capture(BuildContext context) async {}

  Future pickFromGallery(BuildContext context) async {
    //ImagePicker().
  }
}
