import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_me_ii/model/my_user.dart';
import 'package:find_me_ii/ui/home/view_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileDialog extends StatelessWidget {
  const ProfileDialog({super.key, required this.user});

  final MyUser user;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.white.withOpacity(.9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * .6,
          height: MediaQuery.of(context).size.height * .39,
          child: Stack(
            children: [
              Positioned(
                top: MediaQuery.of(context).size.height * .075,
                left: MediaQuery.of(context).size.width * .1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * .25),
                  child: CachedNetworkImage(
                    width: MediaQuery.of(context).size.width * .5,
                    fit: BoxFit.cover,
                    imageUrl: user.image ?? '',
                    // placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const CircleAvatar(
                        child: Icon(CupertinoIcons.person_alt)),
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * .04,
                top: MediaQuery.of(context).size.height * .02,
                width: MediaQuery.of(context).size.width * .55,
                child: Text(
                  user.userName ?? AppLocalizations.of(context)!.findMeUser,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ),
              Positioned(
                  right: 8,
                  top: 4,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ViewProfileScreen(user: user)));
                    },
                    padding: EdgeInsets.all(0),
                    minWidth: 0,
                    shape: CircleBorder(),
                    child: Icon(
                      CupertinoIcons.info_circle_fill,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ))
            ],
          ),
        ));
  }
}
