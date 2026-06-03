
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserService {
  UserService._();
  static final UserService instance = UserService._();

  final _auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance.ref();

  String get _uid => _auth.currentUser!.uid;

  // ── Save user profile ────────────────────────────────────────────
  Future<void> saveProfile({
    required String fullName,
    required String email,
    required String phone,
    required String address,
    String? photoUrl,
  }) async {
    await _db.child('users/$_uid').update({
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'address': address,
      if (photoUrl != null) 'photoUrl': photoUrl,
      'updatedAt': DateTime.now().toIso8601String(),
    });
  }

  // ── Get user profile stream ──────────────────────────────────────
  Stream<Map<String, dynamic>> getProfileStream() {
    return _db.child('users/$_uid').onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) return {};
      return Map<String, dynamic>.from(data as Map);
    });
  }

  // ── Get profile once ─────────────────────────────────────────────
  Future<Map<String, dynamic>> getProfile() async {
    final snapshot = await _db.child('users/$_uid').get();
    if (!snapshot.exists) return {};
    return Map<String, dynamic>.from(snapshot.value as Map);
  }

  // ── Upload profile picture to Firebase Storage ───────────────────
  Future<String?> uploadProfilePicture(File imageFile) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('profile_pictures/$_uid.jpg');
      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }
}