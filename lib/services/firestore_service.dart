
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> updateLocation(
      String familyId, String uid, double lat, double lng) async {
    await _db
        .collection("families")
        .doc(familyId)
        .collection("members")
        .doc(uid)
        .set({
      "lat": lat,
      "lng": lng,
      "timestamp": FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getLocations(String familyId) {
    return _db
        .collection("families")
        .doc(familyId)
        .collection("members")
        .snapshots();
  }
}
