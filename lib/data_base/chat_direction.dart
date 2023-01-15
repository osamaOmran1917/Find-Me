import 'package:find_me_ii/model/my_user.dart';

class ChatDirection {
  static const String collectionName = 'Chat Direction';
  MyUser? user;
  String? message;

  ChatDirection({
    this.user,
    this.message,
  });

  ChatDirection.fromFirestore(Map<String, dynamic> data)
      : this(user: data['user'], message: data['message']);

  Map<String, dynamic> toFirestore() {
    return {
      'user': user,
      'message': message,
    };
  }
}
