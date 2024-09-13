import 'package:emergency_app/core/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/models/notices.dart';

class EmergencyService {
  final _firestore = FirebaseFirestore.instance;
  Future<List<User>> fetchUserByUsername(String userName) async {
    final snapshot = await _firestore
        .collection('users')
        .where('userName', isEqualTo: userName)
        .get();

    final docs = snapshot.docs;

    final users =
        docs.map((document) => User.fromMap(document.data())).toList();
    return users;
  }

  Future<List<Notice>> fetchMyNotices(String userId) async {
    final snapshot = await _firestore
        .collection('notices')
        .where('sentBy', isEqualTo: userId)
        .get();

    final docs = snapshot.docs;

    final notices =
        docs.map((document) => Notice.fromMap(document.data())).toList();
    return notices;
  }

  Future<void> sendNotice(Notice notice) async {
    await _firestore.collection('notices').doc(notice.id).set(notice.toMap());
  }

  Future<void> sendSolicitation(String senderId, String recipientId) async {
    await _firestore.collection('solicitations').add(
        {'sender': senderId, 'recipient': recipientId, 'status': 'pending'});
  }

  Future<void> acceptSolicitation(
      String solicitationId, bool wasAccepted) async {
    await _firestore
        .collection('solicitations')
        .doc(solicitationId)
        .update({'status': wasAccepted ? 'accepted' : 'rejected'});
    final solicitation =
        await _firestore.collection('solicitations').doc(solicitationId).get();
    String senderId = solicitation['sender'];
    String recipientId = solicitation['recipient'];

    if (wasAccepted) {
      final sender = await _firestore.collection('users').doc(senderId).get();
      (sender['contacts']).add(recipientId);
      await _firestore.collection('users').doc(senderId).set(sender.data()!);
    }
  }

  Future<List<String>> fetchSentSolicitations(String userId) async {
    final solicitations = await _firestore
        .collection('solicitations')
        .where('status', isEqualTo: 'pending')
        .where('recipient', isEqualTo: userId)
        .get();
    final users =
        solicitations.docs.map((item) => item['recipient'] as String).toList();
    return users;
  }

  Future<List<Map<String, String>>> fetchRecievedSolicitations(
      String userId) async {
    final solicitations = await _firestore
        .collection('solicitations')
        .where('status', isEqualTo: 'pending')
        .where('recipient', isEqualTo: userId)
        .get();
    final users = solicitations.docs.map((item) {
      final data = item.data() as Map<String, dynamic>;
      return {item.id: item['sender'] as String};
    }).toList();
    return users;
  }

  Future<List<User>> fetchUsers(userId) async {
    final users = await _firestore
        .collection('users')
        .where(FieldPath.documentId, isNotEqualTo: userId)
        .get();
    final userMap = users.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
    print(userMap);
    return userMap.map((user) => User.fromMap(user)).toList();
  }

  Future<List<User>> fetchSolicitationUsers(List<String> userIds) async {
    final users = await _firestore
        .collection('users')
        .where(FieldPath.documentId, whereIn: userIds)
        .get();
    final userMap = users.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
    print(userMap);
    return userMap.map((user) => User.fromMap(user)).toList();
  }
}

final EmergencyService emergencyService = EmergencyService();
