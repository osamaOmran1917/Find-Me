import 'package:find_me_ii/data_base/missing_person.dart';
import 'package:find_me_ii/my_theme.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  MissingPerson missingPerson;

  PostWidget(this.missingPerson);

  @override
  Widget build(BuildContext context) {
    bool status = missingPerson.foundPerson ?? false;
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
                    missingPerson.posterName ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Text(missingPerson.desc ?? ''),
            Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Semakar_white.svg/220px-Semakar_white.svg.png',
              width: MediaQuery.of(context).size.width * .2,
              height: MediaQuery.of(context).size.height * .15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(missingPerson.name ?? 'Name Not Found'),
                Text(
                    '${missingPerson.dateTime?.year.toString()}/${missingPerson.dateTime?.month.toString()}/${missingPerson.dateTime?.day.toString()}'),
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