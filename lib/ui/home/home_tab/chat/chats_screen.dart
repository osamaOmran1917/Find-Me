import 'package:find_me_ii/data_base/my_database.dart';
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
              onPressed: () {},
              child: Icon(Icons.add_comment_rounded),
            ),
          ),
          body: StreamBuilder(
              stream: MyDataBase.getAllUsers(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const Center(child: CircularProgressIndicator());
                  case ConnectionState.active:
                  case ConnectionState.done:
                    final data = snapshot.data?.docs;
                    _list =
                        data?.map((e) => MyUser.fromFierStore(e.data()))
                            .toList() ??
                            [];
                    if (_list.isNotEmpty) {
                      return ListView.builder(
                        padding: EdgeInsets.only(
                            top: MediaQuery
                                .of(context)
                                .size
                                .height * .01),
                        physics: BouncingScrollPhysics(),
                        itemCount: _isSearching ? _searchList.length : _list
                            .length,
                        itemBuilder: (context, index) {
                          return ChatUserCard(user: _isSearching
                              ? _searchList[index]
                              : _list[index]);
                        },
                      );
                    } else {
                      return Center(
                          child: Text(
                            AppLocalizations.of(context)!.noConnectionsFound,
                        style: TextStyle(fontSize: 20),
                      ));
                    }
                }
              }),
        ),
      ),
    );
  }
}