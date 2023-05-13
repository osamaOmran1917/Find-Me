import 'package:find_me_ii/ui/widgets/chat_user_card.dart';

import '../data_base/missing_person.dart';

class MyUser {
  static const String collectionName = 'Users';
  String? id,
      userName,
      email,
      password,
      natId,
      gov,
      phoneNumber,
      image,
      created_at,
      last_active,
      push_token,
      facebook,
      instagram;
  bool? is_online, male;
  List<MissingPerson>? userMissingList;
  List<ChatUserCard>? chatSections;

  MyUser(
      {this.id,
      this.userName,
      this.email,
      this.password,
      this.natId,
      this.gov,
      this.phoneNumber,
      this.image,
      this.created_at,
      this.last_active,
      this.push_token,
      this.facebook,
      this.instagram,
      this.is_online,
      this.male,
      this.userMissingList,
      this.chatSections});

  MyUser.fromFierStore(Map<String, dynamic> data)
      : this(
      id: data['id'],
            userName: data['userName'],
            email: data['email'],
            password: data['password'],
            natId: data['natId'],
            gov: data['gov'],
            phoneNumber: data['phoneNum ber'],
            image: data['image'],
            created_at: data['created_at'],
            last_active: data['last_active'],
            push_token: data['push_token'],
            facebook: data['facebook'],
            instagram: data['instagram'],
            is_online: data['is_online'],
            male: data['male'],
            userMissingList: data['userMissingList'],
            chatSections: data['chatSections']);

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'password': password,
      'natId': natId,
      'gov': gov,
      'phoneNumber': phoneNumber,
      'image': image,
      'created_at': created_at,
      'last_active': last_active,
      'push_token': push_token,
      'facebook': facebook,
      'instagram': instagram,
      'is_online': is_online,
      'male': male,
      'userMissingList': userMissingList,
      'chatSections': chatSections,
    };
  }
}
