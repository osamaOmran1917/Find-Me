import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_me_ii/data_base/missing_person.dart';
import 'package:find_me_ii/data_base/my_database.dart';
import 'package:find_me_ii/my_theme.dart';
import 'package:find_me_ii/shared_data.dart';
import 'package:find_me_ii/ui/home/home_tab/edit_missing_person_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PostDetails extends StatefulWidget {
  static const String routeName = 'Post Details';

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  MissingPerson? missingPerson = SharedData.missingPerson;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: SharedData.user?.userName ==
                missingPerson?.posterName
            ? Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.grey,
                  onPressed: () {
                    print(missingPerson?.reachedToFamily);
                    setState(() {
                      MyDataBase.updateMissingPersonInfo(
                          missingPersonId: (missingPerson?.id)!,
                          reachedFamily: !((missingPerson?.reachedToFamily)!));
                    });
                    print(missingPerson?.reachedToFamily);
                  },
                  icon: Icon(
                    CupertinoIcons.person_crop_circle_badge_checkmark,
                    color: (missingPerson?.reachedToFamily)!
                        ? Colors.lightGreenAccent
                        : Colors.redAccent,
                  ),
                  label: Text((missingPerson?.reachedToFamily)!
                      ? AppLocalizations.of(context)!.haventReachedHisFamilyYet
                      : AppLocalizations.of(context)!.reachedToHisFamily),
                ),
              )
            : null,
        appBar: AppBar(
          title: Text(missingPerson?.name ?? 'Name Not Found',
              style: TextStyle(color: MyTheme.basicWhite)),
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .8,
                height: MediaQuery.of(context).size.height * .6,
                decoration: BoxDecoration(
                    border: Border.all(color: MyTheme.coloredSecondary),
                    borderRadius: BorderRadius.circular(6)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        missingPerson?.desc ?? '',
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      Text(missingPerson?.gov ?? ''),
                      Text(
                        missingPerson?.adress ?? '',
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                          '${AppLocalizations.of(context)!.postDate}: ${missingPerson?.dateTime?.year.toString()}'
                              '/${missingPerson?.dateTime?.month.toString()}'
                              '/${missingPerson?.dateTime?.day.toString()}'),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .1,
                      ),
                      missingPerson?.image == null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.height * .1),
                        child: Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Semakar_white.svg/220px-Semakar_white.svg.png',
                          width: MediaQuery.of(context).size.width * .2,
                          height:
                          MediaQuery.of(context).size.height * .15,
                          fit: BoxFit.cover,
                        ),
                      )
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.height * .021),
                        child: CachedNetworkImage(
                          width: MediaQuery.of(context).size.height * .41,
                          height:
                          MediaQuery.of(context).size.height * .31,
                          fit: BoxFit.fill,
                          imageUrl: missingPerson?.image ?? '',
                          placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const CircleAvatar(
                                        child: Icon(CupertinoIcons.person_alt)),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  SharedData.user?.userName == missingPerson?.posterName
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => EditMissingPersonScreen()))
                      : null;
                },
                child: Text(
                    SharedData.user?.userName == missingPerson?.posterName
                        ? AppLocalizations.of(context)!.edit
                        : AppLocalizations.of(context)!.chat),
              )
            ],
          ),
        ));
  }
}
