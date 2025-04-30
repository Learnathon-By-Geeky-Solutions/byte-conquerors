import 'package:soul_space/features/user_profile/data/datasources/user_profile_remote_data_source.dart';

import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/user_profile_repository.dart';
import '../models/user_profile_model.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileRemoteDataSource remoteDataSource;

  UserProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> saveUserProfile(String userId, UserProfile profile) async {
    final model = UserProfileModel(
      id: int.parse(userId),
      gender: profile.gender,
      helpType: profile.helpType,
      mood: profile.mood,
      sleepHour: profile.sleepHour,
    );
    await remoteDataSource.saveUserProfile(userId, model);
  }

  @override
  Future<UserProfile?> getUserProfile(String userId) async {
    final model = await remoteDataSource.getUserProfile(userId);
    if (model == null) return null;

    return UserProfile(
      id: model.id.toString(),
      gender: model.gender,
      helpType: model.helpType,
      mood: model.mood,
      sleepHour: model.sleepHour,
    );
  }
}
