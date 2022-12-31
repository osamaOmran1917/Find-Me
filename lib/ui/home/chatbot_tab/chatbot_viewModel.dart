import 'package:flutter/foundation.dart';

abstract class ChatBotNavigator {}

class ChatBotViewModel extends ChangeNotifier {
  ChatBotNavigator? navigator;
  List<String> messages = [];
  int counter = 0;

  void M1() {
    messages[counter] = 'I wanna add a missing person';
    // navigator?.viweMessages();
  }
}
