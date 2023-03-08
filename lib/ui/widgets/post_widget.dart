import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_me_ii/data_base/missing_person.dart';
import 'package:find_me_ii/data_base/my_database.dart';
import 'package:find_me_ii/helpers/shared_data.dart';
import 'package:find_me_ii/model/my_user.dart';
import 'package:find_me_ii/ui/home/latest_missing_tab/chat/chat_room.dart';
import 'package:find_me_ii/ui/home/latest_missing_tab/show_picture.dart';
import 'package:find_me_ii/ui/providers/settings_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../home/latest_missing_tab/edit_missing_person_screen.dart';

class PostWidget extends StatefulWidget {
  MissingPerson missingPerson;

  PostWidget(this.missingPerson);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    bool status = widget.missingPerson.foundPerson ?? false;
    return Slidable(
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
                  : Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ChatRoom(user: dUser)));
            },
            icon: SharedData.user?.id == widget.missingPerson.posterId
                ? Icons.edit
                : CupertinoIcons.chat_bubble_2,
            label: SharedData.user?.id == widget.missingPerson.posterId
                ? AppLocalizations.of(context)!.edit
                : AppLocalizations.of(context)!.chat,
          ),
          if (widget.missingPerson.image != null)
            SlidableAction(
              backgroundColor: Colors.grey,
              onPressed: (_) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            ShowPicture(missingPerson: widget.missingPerson)));
              },
              icon: CupertinoIcons.viewfinder,
              label: AppLocalizations.of(context)!.viewPicture,
            )
        ],
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          widget.missingPerson.posterName ?? '',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(widget.missingPerson.desc ?? ''),
              ClipRRect(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.height * .1),
                child: widget.missingPerson.image == null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.height * .1),
                        child: Image.asset(
                          'assets/images/missing.jpg',
                          width: MediaQuery.of(context).size.height * .2,
                          height: MediaQuery.of(context).size.height * .2,
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.height * .1),
                        child: CachedNetworkImage(
                          width: MediaQuery.of(context).size.height * .2,
                          height: MediaQuery.of(context).size.height * .2,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(widget.missingPerson.name ?? 'Name Not Found'),
                  Text(
                      '${widget.missingPerson.dateTime?.year.toString()}/${widget.missingPerson.dateTime?.month.toString()}/${widget.missingPerson.dateTime?.day.toString()}'),
                  Container(
                    width: double.infinity,
                    height: .25,
                    color: Colors.black,
                  )
                ],
              )
            ],
          ),
          Positioned(
            right: status
                ? 0
                : settingsProvider.currentLang == 'en'
                    ? MediaQuery.of(context).size.width * .75
                    : null,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(status
                  ? AppLocalizations.of(context)!.foundPerson
                  : AppLocalizations.of(context)!.lostPerson),
            ),
          ),
          Visibility(
            visible: widget.missingPerson.reachedToFamily!,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .34,
              color: Colors.grey.withOpacity(.59),
            ),
          ),
          Visibility(
            visible: widget.missingPerson.reachedToFamily!,
            child: Image.asset(
              'assets/images/check.png',
              height: MediaQuery.of(context).size.height * .3,
              width: MediaQuery.of(context).size.height * .3,
            ),
          )
        ],
      ),
    );
  }
}
