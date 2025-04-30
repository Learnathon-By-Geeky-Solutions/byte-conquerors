import '../entities/user_profile.dart';

abstract class UserProfileRepository {
  Future<void> saveUserProfile(String userId, UserProfile profile);
  Future<UserProfile?> getUserProfile(String userId);
}
