
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  // create instance of firebase messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // function to initialize notification
  Future<void> initNotifications() async {
    // request permission from user
    await _firebaseMessaging.requestPermission();

    // fetch the FCM token for this device
    String? token = await _firebaseMessaging.getToken();

    // print the token
    print('FirebaseMessaging token: $token');
  }
}