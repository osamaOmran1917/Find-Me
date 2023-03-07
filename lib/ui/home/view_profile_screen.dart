import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_me_ii/data_base/missing_person.dart';
import 'package:find_me_ii/data_base/my_database.dart';
import 'package:find_me_ii/helpers/date_utils.dart';
import 'package:find_me_ii/helpers/my_theme.dart';
import 'package:find_me_ii/helpers/shared_data.dart';
import 'package:find_me_ii/model/my_user.dart';
import 'package:find_me_ii/ui/home/latest_missing_tab/post_details.dart';
import 'package:find_me_ii/ui/widgets/post_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ViewProfileScreen extends StatefulWidget {
  final MyUser user;

  const ViewProfileScreen({super.key, required this.user});

  static const String routeName = 'Profile Tab';

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              widget.user.userName ?? AppLocalizations.of(context)!.findMeUser),
        ),
        floatingActionButton: widget.user.created_at != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'joined on: ',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    getLastMessageTime(
                        context: context,
                        time: widget.user.created_at!,
                        showYear: true),
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  )
                ],
              )
            : null,
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .05),
          child: SingleChildScrollView(
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
                    fit: BoxFit.cover,
                    imageUrl: widget.user.image ?? '',
                    // placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const CircleAvatar(
                        child: Icon(CupertinoIcons.person_alt)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                Text(
                  widget.user.userName!,
                  style: TextStyle(color: Colors.black87, fontSize: 16),
                ),
                if (widget.user.phoneNumber != null)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                if (widget.user.phoneNumber != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.phone_circle,
                        color: Colors.black87,
                      ),
                      Text(
                        widget.user.phoneNumber ?? '',
                        style: TextStyle(color: Colors.black54, fontSize: 15),
                      )
                    ],
                  ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),
                StreamBuilder<QuerySnapshot<MissingPerson>>(
                  builder: (buildContext, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(AppLocalizations.of(context)!
                            .errorLoadingDataTryAgainLater),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                            color: MyTheme.coloredSecondary),
                      );
                    }
                    var data =
                        snapshot.data?.docs.map((e) => e.data()).toList();
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (buildContext, index) {
                        return data.isEmpty
                            ? Center(
                                child: Text(
                                  AppLocalizations.of(context)!.noLostPeople,
                                  style: TextStyle(
                                      color: MyTheme.coloredSecondary,
                                      fontSize: 30),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, PostDetails.routeName,
                                      arguments: SharedData.missingPerson =
                                          data[index]);
                                  print(data[index].id);
                                },
                                child: PostWidget(data[index]));
                      },
                      itemCount: data!.length,
                    );
                  },
                  stream: MyDataBase
                      .listenForMissingPersonsRealTimeUpdatesDependingOnUser(
                          widget.user),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
