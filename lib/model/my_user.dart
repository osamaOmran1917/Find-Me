import '../data_base/missing_person.dart';

class MyUser {
  static const String collectionName = 'Users';
  String? id, userName, email, natId, gov, phoneNumber;
  List<MissingPerson>? userMissingList;

  MyUser({this.id,
    this.userName,
    this.email,
    this.natId,
    this.gov,
    this.phoneNumber,
    this.userMissingList});

  MyUser.fromFierStore(Map<String, dynamic> data)
      : this(
      id: data['id'],
      userName: data['userName'],
      email: data['email'],
      natId: data['natId'],
      gov: data['gov'],
      phoneNumber: data['phoneNumber'],
      userMissingList: data['userMissingList']);

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'natId': natId,
      'gov': gov,
      'phoneNumber': phoneNumber,
      'userMissingList': userMissingList
    };
  }
}
