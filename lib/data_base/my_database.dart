import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_me_ii/data_base/missing_person.dart';
import 'package:find_me_ii/date_utils.dart';
import 'package:find_me_ii/model/my_user.dart';
import 'package:find_me_ii/shared_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

  static Future<MissingPerson?> getMissingPersonById(String id) async {
    var collection = getMissingPersonsCollection();
    var docRef = collection.doc(id);
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

  static Future<void> insertMissingPerson(MissingPerson missingPerson) {
    var missingPersonsCollection = getMissingPersonsCollection();
    var doc = missingPersonsCollection.doc(); //create new doc
    missingPerson.id = doc.id;
    return doc.set(missingPerson); // get doc -> then set //update
  }

  static Future<QuerySnapshot<MissingPerson>>
      getAllMissingPersonsDependingOnDate(DateTime selectedDate) async {
    // Read data once.
    return await getMissingPersonsCollection()
        .where('dateTime',
            isEqualTo: dateOnly(selectedDate).millisecondsSinceEpoch)
        .get();
  }

  static Future<QuerySnapshot<MissingPerson>> getAllMissingPersons() async {
    // Read data once.
    return await getMissingPersonsCollection()
        .orderBy("dateTime", descending: true)
        .get();
  }

  static Stream<QuerySnapshot<MissingPerson>>
      listenForMissingPersonsRealTimeUpdates() {
    // Listen for realtime update
    return getMissingPersonsCollection()
        .orderBy("dateTime", descending: true)
        .snapshots();
  }

  static Stream<QuerySnapshot<MissingPerson>>
      listenForMissingPersonsRealTimeUpdatesDependingOnUser(MyUser user) {
    // Listen for realtime update
    return getMissingPersonsCollection()
        .where('posterId', isEqualTo: user.id)
        .orderBy("dateTime", descending: true)
        .snapshots();
  }

  static Stream<QuerySnapshot<MissingPerson>>
      listenForMissingPersonsRealTimeUpdatesDependingOnDate(
          DateTime selectedDate) {
    // Listen for realtime update
    return getMissingPersonsCollection()
        .where('dateTime',
            isEqualTo: dateOnly(selectedDate).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<List<MissingPerson>?> getUserPosts(String uid) async {
    var collection = getUsersCollection();
    var docRef = collection.doc(uid);
    var res = await docRef.get();
    var data = res.data();
    return data?.userMissingList;
  }

  static editReachedFamiley(MissingPerson missingPerson) {
    CollectionReference findMeRef = getMissingPersonsCollection();
    findMeRef.doc(missingPerson.id).update(
        {'reachedToFamily': missingPerson.reachedToFamily! ? false : true});
  }

  /*editMissingPersonPic(MissingPerson missingPerson) {
    CollectionReference findMeRef = getMissingPersonsCollection();
    findMeRef.doc(missingPerson.id).update({

    });
  }*/

  static FirebaseAuth auth = FirebaseAuth.instance;

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static FirebaseStorage storage = FirebaseStorage.instance;

  static late MyUser me;

  static User get user => auth.currentUser!;

  static Future<bool> userExists() async {
    return (await firestore.collection('Users').doc(user.uid).get()).exists;
  }

  static Future<void> getSelfInfo() async {
    await firestore.collection('Users').doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = MyUser.fromFierStore(user.data()!);
        SharedData.user = me;
        log('My Data: ${user.data()}');
      } else {
        await createUser().then((value) => getSelfInfo());
      }
    });
  }

  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = MyUser(
        id: user.uid,
        userName: user.displayName.toString(),
        email: user.email.toString(),
        image: user.photoURL.toString(),
        created_at: time,
        is_online: false,
        last_active: time,
        push_token: '');
    return await firestore
        .collection('Users')
        .doc(user.uid)
        .set(chatUser.toFireStore());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection('Users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  static Future<void> updateUserInfo() async {
    await firestore
        .collection('Users')
        .doc(user.uid)
        .update({'userName': me.userName, 'phoneNumber': me.phoneNumber});
  }

  static Future<void> updateProfilePicture(File file) async {
    final ext = file.path.split('.').last;
    final ref = storage.ref().child('profile_pictures/${user.uid}.$ext');
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext'));
    me.image = await ref.getDownloadURL();
    await firestore
        .collection('Users')
        .doc(user.uid)
        .update({'image': me.image});
  }

/*static Future<void> updateMissingPersonPicture(
      File file) async {
    final ext = file.path.split('.').last;
    final ref =
        storage.ref().child('lost_people_pictures/${SharedData.missingPerson!.id}.$ext');
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext'));
    me.image = await ref.getDownloadURL();
    await firestore
        .collection('Missing Person')
        .doc(SharedData.missingPerson!.id)
        .update({'image': SharedData.missingPerson!.image});
  }*/
}
