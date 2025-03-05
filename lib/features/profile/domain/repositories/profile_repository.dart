import '../models/user_profile_model.dart';

abstract class ProfileRepository {
  Future<UserProfile> getUserProfile(String id);
  Future<void> updateUserProfile(UserProfile profile);
}
