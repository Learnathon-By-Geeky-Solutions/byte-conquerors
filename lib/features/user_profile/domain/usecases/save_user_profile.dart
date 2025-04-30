import '../entities/user_profile.dart';
import '../repositories/user_profile_repository.dart';

class SaveUserProfile {
  final UserProfileRepository repository;

  SaveUserProfile(this.repository);

  Future<void> call(String userId, UserProfile profile) {
    return repository.saveUserProfile(userId, profile);
  }
}
