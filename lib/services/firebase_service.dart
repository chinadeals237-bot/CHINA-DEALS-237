import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Future<Map<String, dynamic>?> getCurrentUserData() async {
    if (currentUser == null) return null;
    final doc = await _firestore.collection('users').doc(currentUser!.uid).get();
    return doc.data();
  }

  Stream<QuerySnapshot> getTachesSelonStatut(String statut) {
    if (statut == 'Standard') {
      return _firestore
          .collection('tasks')
          .where('prix', isLessThanOrEqualTo: 100000)
          .snapshots();
    } else {
      return _firestore.collection('tasks').snapshots();
    }
  }

  Future<void> signalerTache(String taskId) async {
    await _firestore.collection('tasks').doc(taskId).update({
      'signalé_par': currentUser?.uid,
      'signalé_le': DateTime.now(),
    });
  }
}