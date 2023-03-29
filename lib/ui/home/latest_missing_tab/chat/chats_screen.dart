import 'package:find_me_ii/data_base/my_database.dart';
import 'package:find_me_ii/helpers/dialog_utils.dart';
import 'package:find_me_ii/model/my_user.dart';
import 'package:find_me_ii/ui/widgets/chat_user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatsScreen extends StatefulWidget {
  static const String routeName = 'Chats Screen';

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  List<MyUser> _list = [];
  final List<MyUser> _searchList = [];
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          if (_isSearching) {
            setState(() {
              _isSearching = !_isSearching;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: const Icon(CupertinoIcons.chat_bubble_2_fill),
            title: _isSearching
                ? TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                      hintText: AppLocalizations.of(context)!.nameEmailEtc,
                      hintStyle: TextStyle(color: Colors.white),
                    ),
              autofocus: true,
              style: TextStyle(
                  color: Colors.white, fontSize: 17, letterSpacing: .5),
              onChanged: (val) {
                _searchList.clear();
                for (var i in _list) {
                  if (i.userName!.toLowerCase().contains(val.toLowerCase()) ||
                      i.phoneNumber!
                          .toLowerCase()
                                .contains(val.toLowerCase()) ||
                            i.email!
                                .toLowerCase()
                                .contains(val.toLowerCase())) {
                          _searchList.add(i);
                        }
                        setState(() {
                          _searchList;
                        });
                      }
                    },
                  )
                : Text(AppLocalizations.of(context)!.chat),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      _isSearching = !_isSearching;
                    });
                  },
                  icon: Icon(_isSearching
                      ? CupertinoIcons.clear_circled_solid
                      : CupertinoIcons.search)),
            ],
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FloatingActionButton(
              onPressed: () {
                _addUserDialog();
              },
              child: Icon(Icons.add_comment_rounded),
            ),
          ),
          body: StreamBuilder(
            stream: MyDataBase.getMyUsersIDs(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.active:
                case ConnectionState.done:
                  return StreamBuilder(
                      stream: MyDataBase.getAllUsers(
                          snapshot.data?.docs.map((e) => e.id).toList() ?? []),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                          case ConnectionState.none:
                          // return const Center(child: CircularProgressIndicator());
                          case ConnectionState.active:
                          case ConnectionState.done:
                            final data = snapshot.data?.docs;
                            _list = data
                                    ?.map((e) => MyUser.fromFierStore(e.data()))
                                    .toList() ??
                                [];
                            if (_list.isNotEmpty) {
                              return ListView.builder(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        .01),
                                physics: BouncingScrollPhysics(),
                                itemCount: _isSearching
                                    ? _searchList.length
                                    : _list.length,
                                itemBuilder: (context, index) {
                                  return ChatUserCard(
                                      user: _isSearching
                                          ? _searchList[index]
                                          : _list[index]);
                                },
                              );
                            } else {
                              return Center(
                                  child: Text(
                                AppLocalizations.of(context)!
                                    .noConnectionsFound,
                                style: TextStyle(fontSize: 20),
                              ));
                            }
                        }
                      });
              }
            },
          ),
        ),
      ),
    );
  }

  void _addUserDialog() {
    String email = '';
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding:
                  EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Row(children: [
                Icon(CupertinoIcons.person_add_solid,
                    color: Colors.blue, size: 28),
                Text('  add user')
              ]),
              content: TextFormField(
                  maxLines: null,
                  onChanged: (value) => email = value,
                  decoration: InputDecoration(
                      hintText: 'Email ID',
                      prefixIcon: Icon(
                        CupertinoIcons.mail_solid,
                        color: Colors.blue,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)))),
              actions: [
                MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('cancel',
                        style: TextStyle(color: Colors.blue, fontSize: 16))),
                MaterialButton(
                    onPressed: () async {
                      if (email.isNotEmpty)
                        await MyDataBase.addUser(email).then((value) {
                          if (!value) {
                            Dialogs.showSnackbar(
                                context, 'There is no users with this email');
                          }
                        });
                      Navigator.pop(context);
                    },
                    child: Text('add',
                        style: TextStyle(color: Colors.blue, fontSize: 16)))
              ],
            ));
  }
}