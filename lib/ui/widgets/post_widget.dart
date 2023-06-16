import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_me_ii/data_base/missing_person.dart';
import 'package:find_me_ii/data_base/my_database.dart';
import 'package:find_me_ii/helpers/dialog_utils.dart';
import 'package:find_me_ii/helpers/shared_data.dart';
import 'package:find_me_ii/model/my_user.dart';
import 'package:find_me_ii/ui/home/latest_missing_tab/chat/chat_room.dart';
import 'package:find_me_ii/ui/home/latest_missing_tab/show_picture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gallery_saver/gallery_saver.dart';

import '../home/latest_missing_tab/edit_missing_person_screen.dart';

class PostWidget extends StatefulWidget {
  MissingPerson missingPerson;

  PostWidget(this.missingPerson);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  String? _image;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height,
        width = MediaQuery.of(context).size.width;
    bool found = widget.missingPerson.foundPerson ?? false;
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * .04),
      child: Slidable(
        startActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              backgroundColor: Colors.blue,
              onPressed: (_) async {
                MyUser dUser = await MyDataBase.getFutureOfUserById(
                    widget.missingPerson.posterId!) as MyUser;
                SharedData.user?.id == widget.missingPerson.posterId
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => EditMissingPersonScreen(
                                  missingPerson: widget.missingPerson,
                                )))
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ChatRoom(user: dUser)));
              },
              icon: SharedData.user?.id == widget.missingPerson.posterId
                  ? Icons.edit
                  : CupertinoIcons.chat_bubble_2,
            ),
            if (widget.missingPerson.image != null)
              SlidableAction(
                backgroundColor: Colors.grey,
                onPressed: (_) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ShowPicture(
                              missingPerson: widget.missingPerson)));
                },
                icon: CupertinoIcons.viewfinder,
              ),
            if (widget.missingPerson.image != null)
              SlidableAction(
                backgroundColor: Colors.green,
                onPressed: (_) async {
                  try {
                    await GallerySaver.saveImage(
                            widget.missingPerson.image ?? '',
                            albumName: 'Find Me')
                        .then((success) {
                      if (success != null && success)
                        Dialogs.showSnackbar(context, 'Saved To Gallery!');
                    });
                  } catch (e) {
                    log('Error While Saving Image $e');
                  }
                },
                icon: Icons.download_rounded,
              ),
            if (SharedData.user?.id == widget.missingPerson.posterId)
              SlidableAction(
                backgroundColor: Colors.red,
                onPressed: (_) {
                  showMessage(
                      context,
                      AppLocalizations.of(context)!
                          .areYouSureYouWannaDeleteThisMissingPerson,
                      posAction: () async {
                    await MyDataBase.deleteMissingPerson(
                        missingPersonId: widget.missingPerson.id ?? '');
                  },
                      posActionName: AppLocalizations.of(context)!.yes,
                      negAction: () {},
                      negActionName: AppLocalizations.of(context)!.no);
                },
                icon: CupertinoIcons.delete_solid,
              )
          ],
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: height * .0005,
              color: Colors.black,
            ),
            SizedBox(
              height: height * .005,
            ),
            Row(
              children: [
                _image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.height * .1),
                        child: Image.file(
                          File(_image!),
                          width: MediaQuery.of(context).size.height * .045,
                          height: MediaQuery.of(context).size.height * .045,
                          fit: BoxFit.cover,
                          // placeholder: (context, url) => CircularProgressIndicator(),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.height * .1),
                        child: CachedNetworkImage(
                          width: MediaQuery.of(context).size.height * .045,
                          height: MediaQuery.of(context).size.height * .045,
                          fit: BoxFit.cover,
                          imageUrl: widget.missingPerson.posterImage ?? '',
                          // placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const CircleAvatar(
                                  child: Icon(CupertinoIcons.person_alt)),
                        ),
                      ),
                SizedBox(
                  width: width * .03,
                ),
                Text(widget.missingPerson.posterName ?? ''),
              ],
            ),
            SizedBox(
              height: height * .005,
            ),
            Container(
              width: double.infinity,
              height: height * .0005,
              color: Colors.black,
            ),
            Row(
              children: [
                Column(
                  children: [
                    ClipRRect(
                      /*borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height * .1),*/
                      child: widget.missingPerson.image == null
                          ? ClipRRect(
                              /*borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.height * .1),*/
                              child: Image.asset(
                                'assets/images/missing.jpg',
                                width: width * .45,
                                // height: MediaQuery.of(context).size.height * .2,
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipRRect(
                              /*borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.height * .1),*/
                              child: CachedNetworkImage(
                                width: width * .45,
                                // height: height * .45,
                                fit: BoxFit.cover,
                                imageUrl: widget.missingPerson.image ?? '',
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const CircleAvatar(
                                        child: Icon(CupertinoIcons.person_alt)),
                              ),
                            ),
                    ),
                    Container(
                      width: width * .45,
                      height: height * .0005,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: width * .45,
                      child: Text(
                        widget.missingPerson.desc ?? '',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * .015,
                        ),
                        Row(
                          children: [
                            Icon(CupertinoIcons.location_solid),
                            Text(widget.missingPerson.adress ?? '')
                          ],
                        ),
                        SizedBox(
                          height: height * .015,
                        ),
                        Container(
                          width: width * .45,
                          height: height * .0005,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: height * .015,
                        ),
                        Row(
                          children: [
                            Icon(Icons.date_range),
                            SizedBox(
                              width: width * .03,
                            ),
                            Text(
                                '${widget.missingPerson.dateTime?.year.toString()}/${widget.missingPerson.dateTime?.month.toString()}/${widget.missingPerson.dateTime?.day.toString()}'),
                          ],
                        ),
                        SizedBox(
                          height: height * .015,
                        ),
                        Container(
                          width: width * .45,
                          height: height * .0005,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: height * .015,
                        ),
                        Text(AppLocalizations.of(context)!.age +
                            ':' +
                            (widget.missingPerson.age ?? ''))
                      ],
                    ),
                  ),
                )
              ],
            ),
            Container(
              width: double.infinity,
              height: height * .0005,
              color: Colors.black,
            ),
            SizedBox(
              height: height * .005,
            ),
            Text(
              widget.missingPerson.foundPerson!
                  ? AppLocalizations.of(context)!.foundPerson
                  : AppLocalizations.of(context)!.lostPerson,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(
              height: height * .005,
            ),
            Container(
              width: double.infinity,
              height: height * .0005,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
