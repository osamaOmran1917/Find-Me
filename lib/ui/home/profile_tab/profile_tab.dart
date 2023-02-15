import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_me_ii/model/my_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileTab extends StatefulWidget {
  final MyUser user;

  const ProfileTab({super.key, required this.user});

  static const String routeName = 'Chat Screen';

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.redAccent,
          onPressed: () {},
          icon: Icon(Icons.logout),
          label: Text(AppLocalizations.of(context)!.logOut),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .05),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .03,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.height * .1),
              child: CachedNetworkImage(
                  width: MediaQuery.of(context).size.height * .2,
                  height: MediaQuery.of(context).size.height * .2,
                  fit: BoxFit.fill,
                  imageUrl: widget.user.image ?? '',
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => CircleAvatar(
                        child: Icon(CupertinoIcons.person_alt),
                      )),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            Text(
              widget.user.userName!,
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
            ),
            TextFormField(
              initialValue: widget.user.userName,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  prefixIcon: Icon(
                    CupertinoIcons.person_alt,
                    color: Colors.blue,
                  ),
                  hintText: 'eg. Ahmed Adam',
                  label: Text('Name')),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            TextFormField(
              initialValue: widget.user.phoneNumber,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  prefixIcon: Icon(
                    CupertinoIcons.phone_fill,
                    color: Colors.blue,
                  ),
                  hintText: 'eg. +201234567890',
                  label: Text('Phone Number')),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                size: 25,
              ),
              label: Text(
                'UPDATE',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  minimumSize: Size(MediaQuery.of(context).size.width * .5,
                      MediaQuery.of(context).size.height * .06)),
            )
          ],
        ),
      ),
    );
  }
}
