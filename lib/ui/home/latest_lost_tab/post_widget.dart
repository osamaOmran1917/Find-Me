import 'package:find_me_ii/data_base/missing_person.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  MissingPerson missingPerson;

  PostWidget(this.missingPerson);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 22, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/Shai5Messi.jpg',
            width: MediaQuery.of(context).size.width * .2,
            height: MediaQuery.of(context).size.height * .15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(missingPerson.name ?? ''),
              Text('القليوبية'),
              Text('15/10/2021')
            ],
          )
        ],
      ),
    );
  }
}
