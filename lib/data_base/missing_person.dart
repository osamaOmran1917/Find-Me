import 'dart:io';

import 'package:find_me_ii/model/my_user.dart';
import 'package:find_me_ii/shared_data.dart';

class MissingPerson {
  static const String collectionName = 'Missing Person';
  String? id, name, adress, desc, age, gov;
  DateTime? dateTime;
  bool? reachedToFamily;
  File? image;
  MyUser? poster = SharedData.user;

  MissingPerson(
      {this.id,
      this.name,
      this.adress,
      this.desc,
      this.age,
      this.gov,
      this.dateTime,
      this.reachedToFamily,
      this.image});

  MissingPerson.fromFirestore(Map<String, dynamic> data)
      : this(
      id: data['id'],
            name: data['name'],
            adress: data['adress'],
            desc: data['desc'],
            age: data['age'],
            gov: data['gov'],
            dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
            reachedToFamily: data['isFound'],
            image: data['image']);

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'adress': adress,
      'desc': desc,
      'age': age,
      'gov': gov,
      'dateTime': dateTime?.millisecondsSinceEpoch,
      'isFound': reachedToFamily,
      'image': image,
    };
  }
}
