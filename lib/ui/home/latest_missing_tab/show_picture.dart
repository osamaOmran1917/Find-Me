import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_me_ii/data_base/missing_person.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowPicture extends StatelessWidget {
  const ShowPicture({Key? key, required this.missingPerson}) : super(key: key);

  final MissingPerson missingPerson;

  @override
  Widget build(BuildContext context) {
    return missingPerson.image == null
        ? ClipRRect(
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.height * .1),
            child: Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Semakar_white.svg/220px-Semakar_white.svg.png',
              width: MediaQuery.of(context).size.width * .2,
              height: MediaQuery.of(context).size.height * .15,
              fit: BoxFit.cover,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(
                MediaQuery.of(context).size.height * .021),
            child: CachedNetworkImage(
              // width: MediaQuery.of(context).size.height * .41,
              /* height:
                          MediaQuery.of(context).size.height * .31,*/
              fit: BoxFit.contain,
              imageUrl: missingPerson.image ?? '',
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  const CircleAvatar(child: Icon(CupertinoIcons.person_alt)),
            ),
          );
  }
}
