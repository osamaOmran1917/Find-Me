import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_me_ii/data_base/missing_person.dart';
import 'package:find_me_ii/ui/providers/settings_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

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
    return Stack(
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
                  MediaQuery
                      .of(context)
                      .size
                      .height * .1),
              child: widget.missingPerson.image == null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.height * .1),
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Semakar_white.svg/220px-Semakar_white.svg.png',
                  width: MediaQuery.of(context).size.width * .2,
                  height: MediaQuery.of(context).size.height * .15,
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
                    '${widget.missingPerson.dateTime?.year.toString()}/${widget
                        .missingPerson.dateTime?.month.toString()}/${widget.missingPerson.dateTime?.day.toString()}'),
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
    );
  }
}