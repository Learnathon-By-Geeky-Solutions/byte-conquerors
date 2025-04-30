import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_profile_model.dart';

abstract class UserProfileRemoteDataSource {
  Future<void> saveUserProfile(String userId, UserProfileModel profile);
  Future<UserProfileModel?> getUserProfile(String userId);
}

class UserProfileRemoteDataSourceImpl implements UserProfileRemoteDataSource {
  final FirebaseFirestore firestore;

  UserProfileRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> saveUserProfile(String userId, UserProfileModel profile) async {
    await firestore
        .collection('user_profiles')
        .doc(userId)
        .set(profile.toJson());
  }

  @override
  Future<UserProfileModel?> getUserProfile(String userId) async {
    final doc = await firestore.collection('user_profiles').doc(userId).get();
    if (doc.exists) {
      return UserProfileModel.fromJson(doc.data()!);
    }
    return null;
  }
}
