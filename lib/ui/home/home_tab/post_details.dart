import 'package:find_me_ii/data_base/missing_person.dart';
import 'package:find_me_ii/my_theme.dart';
import 'package:find_me_ii/shared_data.dart';
import 'package:flutter/material.dart';

class PostDetails extends StatelessWidget {
  static const String routeName = 'Post Details';

  MissingPerson? missingPerson = SharedData.missingPerson;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          'Post Date: ${missingPerson?.dateTime?.year.toString()}'
                          '/${missingPerson?.dateTime?.month.toString()}'
                          '/${missingPerson?.dateTime?.day.toString()}'),
                    ],
                  ),
                ),
              ),
              Visibility(
                  visible: SharedData.user?.id == missingPerson?.userId
                      ? true
                      : false,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Chat'),
                  ))
            ],
          ),
        ));
  }
}
