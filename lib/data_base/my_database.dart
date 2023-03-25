import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_me_ii/data_base/missing_person.dart';
import 'package:find_me_ii/helpers/date_utils.dart';
import 'package:find_me_ii/helpers/shared_data.dart';
import 'package:find_me_ii/model/message.dart';
import 'package:find_me_ii/model/my_user.dart';
import 'package:find_me_ii/ui/home/latest_missing_tab/latest_lost_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart';

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

  static Future<MyUser?> getFutureOfUserById(String uid) async {
    var collection = getUsersCollection();
    var docRef = collection.doc(uid);
    var res = await docRef.get();
    return res.data();
  }

  static MyUser getUserById(String uid) {
    return getFutureOfUserById(uid) as MyUser;
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
    var docRef;
    for (int i = 0; i < all.length; i++) {
      docRef = FirebaseFirestore.instance
          .collection(MissingPerson.collectionName)
          .doc(all[i].id);
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          if (all[i].name == missingPerson.name) {
            print('أهو');
          }
        },
        onError: (e) => print("Error getting document: $e"),
      );
    }
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
  listenForMissingPersonsRealTimeUpdatesDependingOnDate(DateTime selectedDate) {
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

  static FirebaseAuth auth = FirebaseAuth.instance;

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static FirebaseStorage storage = FirebaseStorage.instance;

  static late MyUser me;

  static User get user => auth.currentUser!;

  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;

  static Future<void> getFirebaseMessagingToken() async {
    await fMessaging.requestPermission();
    await fMessaging.getToken().then((t) {
      if (t != null) {
        me.push_token = t;
        SharedData.user?.push_token = t;
        log('Push Token Harsh: $t');
      }
    });
    /*FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification}');
      }
    });*/
  }

  static Future<void> sendPushNotification(MyUser myUser, String msg) async {
    try {
      final body = {
        "to": myUser.push_token,
        "notification": {
          "title": myUser.userName,
          "body": msg,
          "android_channel_id": "chats",
        },
        "data": {
          "some_data": "User ID: ${me.id}",
        },
      };
      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'key=AAAAC4MkweQ:APA91bGDZYK3xUc9woCoS3UVVQ2ZmsgLoUelf_EywNHixnJCbRndPLpgvmlI__CKAJ0pzJQdg9qRVuisfoZr07iL0D44LJ2PyqSfO0EcJheKQ0oj_GlOMP7EFLdtrcxnnRzEyyX-f5Kl'
          },
          body: jsonEncode(body));
      log('Response status: ${res.statusCode}');
      log('Response body: ${res.body}');
    } catch (e) {
      log('\nsendPushNotificationE: $e');
    }
  }

  static Future<bool> userExists() async {
    return (await firestore.collection('Users').doc(user.uid).get()).exists;
  }

  static Future<void> getSelfInfo() async {
    await firestore.collection('Users').doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = MyUser.fromFierStore(user.data()!);
        SharedData.user = me;
        await getFirebaseMessagingToken();
        MyDataBase.updateActiveStatus(true);
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

  static Future<void> customUpdateUserInfo({String? address}) async {
    await firestore
        .collection('Users')
        .doc(SharedData.user?.id ?? me.id)
        .update({'gov': address});
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

  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(MyUser myUser) {
    return firestore
        .collection('Users')
        .where('id', isEqualTo: myUser.id)
        .snapshots();
  }

  static Future<void> updateActiveStatus(bool isOnline) async {
    firestore.collection('Users').doc(SharedData.user?.id ?? user.uid).update({
      'is_online': isOnline,
      'last_active': DateTime.now().millisecondsSinceEpoch.toString(),
      'push_token': me.push_token,
    });
  }

  static Future<void> updateMissingPersonInfo({required MissingPerson missingPerson,
    bool? reachedFamily,
    String? name}) async {
    await firestore.collection('Missing Person').doc(missingPerson.id).update({
      'reachedToFamily': reachedFamily ?? missingPerson.reachedToFamily,
      'name': name ?? missingPerson.name
    });
  }

  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(MyUser user) {
    return firestore
        .collection('chats/${getConversationID(user.id!)}/messages')
        .orderBy('sent', descending: true)
        .snapshots();
  }

  static Future<void> sendMessage(MyUser chatUser, String msg, Type type) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final Message message = Message(
        toId: chatUser.id!,
        msg: msg,
        read: '',
        type: type,
        fromId: user.uid,
        sent: time);
    final ref = firestore
        .collection('chats/${getConversationID(chatUser.id!)}/messages/');
    await ref.doc(time).set(message.toJson()).then((value) =>
        sendPushNotification(chatUser, type == Type.text ? msg : 'image'));
  }

  static Future<void> updateMessageReadStatus(Message message) async {
    firestore
        .collection('chats/${getConversationID(message.fromId)}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(MyUser user) {
    return firestore
        .collection('chats/${getConversationID(user.id!)}/messages')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  static Future<void> sendChatImage(MyUser myUser, File file) async {
    final ext = file.path.split('.').last;
    final ref = storage.ref().child(
        'images/${getConversationID(myUser.id!)}/${DateTime.now().millisecondsSinceEpoch}.$ext');
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });
    final imageUrl = await ref.getDownloadURL();
    await sendMessage(myUser, imageUrl, Type.image);
  }

  static Future<void> deleteMissingPerson({required String missingPersonId}) async {
    await firestore.collection('Missing Person').doc(missingPersonId).delete();
  }
}
