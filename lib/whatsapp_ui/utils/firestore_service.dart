import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference _userData =
      FirebaseFirestore.instance.collection('users');

  // Updates user data
  Future<void> updateUserData(
      String fcmTokenIdentifier, String phoneNumber) async {
    final reference = _userData.doc(fcmTokenIdentifier);

    await reference.set({
      'number': phoneNumber, // Mobile Number of User
      'token': fcmTokenIdentifier, // FCM Token
    });
  }
}
