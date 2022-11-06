class MyUser {
  static const String collectionName = 'Users';
  String? id, userName, email;

  MyUser({this.id, this.userName, this.email});

  MyUser.fromFierStore(Map<String, dynamic> data)
      : this(id: data['id'], userName: data['userName'], email: data['email']);

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'userName': userName,
      'email': email
    };
  }
}