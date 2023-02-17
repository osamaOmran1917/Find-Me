import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_me_ii/data_base/missing_person.dart';
import 'package:find_me_ii/my_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatefulWidget {
  MissingPerson missingPerson;

  PostWidget(this.missingPerson);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    bool status = widget.missingPerson.foundPerson ?? false;
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Column(
          children: [
            Row(
              children: [
                Icon(Icons.check_circle),
                Expanded(
                  child: Container(),
                ),
                CircleAvatar(
                  backgroundColor: MyTheme.basicWhite.withOpacity(.2),
                  child: PopupMenuButton(
                      onSelected: (value) {},
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text('Edit'),
                          value: 'Edit',
                        )
                      ]),
                )
              ],
            ),
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
            Text(widget.missingPerson.desc ?? ''),
            /*Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Semakar_white.svg/220px-Semakar_white.svg.png',
              width: MediaQuery.of(context).size.width * .2,
              height: MediaQuery.of(context).size.height * .15,
            ),*/
            ClipRRect(
              borderRadius: BorderRadius.circular(
                  MediaQuery
                      .of(context)
                      .size
                      .height * .1),
              child: /*CachedNetworkImage(
                  width: MediaQuery.of(context).size.height * .2,
                  height: MediaQuery.of(context).size.height * .2,
                  fit: BoxFit.cover,
                  imageUrl: widget.missingPerson.image ?? '',
                  //imageUrl: widget.missingPerson.image!, دي اللي ودتني في داهية يوم بحاله ركز
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => CircleAvatar(
                        child: Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Semakar_white.svg/220px-Semakar_white.svg.png',
                          width: MediaQuery.of(context).size.width * .2,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * .15,
                          fit: BoxFit.cover,
                        ),
                      ))*/
                  widget.missingPerson.image == null
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
                        .missingPerson.dateTime?.month.toString()}/${widget
                        .missingPerson.dateTime?.day.toString()}'),
                Container(
                  width: double.infinity,
                  height: .25,
                  color: Colors.black,
                )
              ],
            )
          ],
        ),
        Text(status ? 'Found' : 'Missed')
      ],
    );
  }
}