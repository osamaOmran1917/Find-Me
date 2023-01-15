import 'package:find_me_ii/data_base/chat_direction.dart';

import '../data_base/missing_person.dart';

class MyUser {
  static const String collectionName = 'Users';
  String? id, userName, email, password, natId, gov, phoneNumber;
  List<MissingPerson>? userMissingList;
  List<ChatDirection>? chatDirections;

  MyUser(
      {this.id,
      this.userName,
      this.email,
      this.password,
      this.natId,
      this.gov,
      this.phoneNumber,
      this.userMissingList,
      this.chatDirections});

  MyUser.fromFierStore(Map<String, dynamic> data)
      : this(
            id: data['id'],
            userName: data['userName'],
            email: data['email'],
            password: data['password'],
            natId: data['natId'],
            gov: data['gov'],
            phoneNumber: data['phoneNumber'],
            userMissingList: data['userMissingList'],
            chatDirections: data['chatDirections']);

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'password': password,
      'natId': natId,
      'gov': gov,
      'phoneNumber': phoneNumber,
      'userMissingList': userMissingList,
      'chatDirections': chatDirections,
    };
  }
}
