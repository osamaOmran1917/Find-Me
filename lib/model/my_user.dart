class MyUser {
  static const String collectionName = 'Users';
  String? id, userName, email, natId, gov, phoneNumber;

  MyUser(
      {this.id,
      this.userName,
      this.email,
      this.natId,
      this.gov,
      this.phoneNumber});

  MyUser.fromFierStore(Map<String, dynamic> data)
      : this(id: data['id'], userName: data['userName'], email: data['email']);

  Map<String, dynamic> toFireStore() {
    return {'id': id, 'userName': userName, 'email': email};
  }
}