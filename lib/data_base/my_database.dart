import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_me_ii/data_base/missing_person.dart';
import 'package:find_me_ii/model/my_user.dart';

class MyDataBase {
  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: (doc, _) => MyUser.fromFierStore(doc.data()!),
            toFirestore: (user, options) => user.toFireStore());
  }

  static Future<MyUser?> insertUser(MyUser user) async {
    var collection = getUsersCollection();
    var docRef = collection.doc(user.id);
    var res = await docRef.set(user);
    return user;
  }

  static Future<MyUser?> getUserById(String uid) async {
    var collection = getUsersCollection();
    var docRef = collection.doc(uid);
    var res = await docRef.get();
    return res.data();
  }

  static CollectionReference<MissingPerson> getMissingPersonsCollection() {
    return FirebaseFirestore.instance
        .collection(MissingPerson.collectionName)
        .withConverter<MissingPerson>(fromFirestore: (snapshot, options) {
      return MissingPerson.fromFirestore(snapshot.data()!);
    }, toFirestore: (missingPerson, options) {
      return missingPerson.toFirestore();
    });
  }

  void insertMissingPerson(MissingPerson missingPerson) {
    var missingPersonsCollection = getMissingPersonsCollection();
    var doc = missingPersonsCollection.doc(); //create new doc
    missingPerson.id = doc.id;
    doc.set(missingPerson); // get doc -> then set //update
  }
}