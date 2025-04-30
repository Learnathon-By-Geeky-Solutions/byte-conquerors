import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_space/features/user_profile/domain/usecases/get_user_profile.dart';
import 'package:soul_space/features/user_profile/domain/usecases/save_user_profile.dart';

import '../../domain/entities/user_profile.dart';
import 'user_profile_event.dart';
import 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final SaveUserProfile saveUserProfile;
  final GetUserProfile getUserProfile;

  UserProfileBloc({
    required this.saveUserProfile,
    required this.getUserProfile,
  }) : super(UserProfileInitial()) {
    on<UpdateGender>(_onUpdateGender);
    on<UpdateHelpType>(_onUpdateHelpType);
    on<UpdateMood>(_onUpdateMood);
    on<UpdateSleepHour>(_onUpdateSleepHour);
    on<SaveUserProfileEvent>(_onSaveUserProfile);
    on<LoadUserProfile>(_onLoadUserProfile); // Add this
  }

  void _onUpdateGender(UpdateGender event, Emitter<UserProfileState> emit) {
    final currentProfile = (state is UserProfileUpdated)
        ? (state as UserProfileUpdated).profile
        : UserProfile();
    emit(UserProfileUpdated(currentProfile.copyWith(gender: event.gender)));
  }

  void _onUpdateHelpType(UpdateHelpType event, Emitter<UserProfileState> emit) {
    final currentProfile = (state is UserProfileUpdated)
        ? (state as UserProfileUpdated).profile
        : UserProfile();
    emit(UserProfileUpdated(currentProfile.copyWith(helpType: event.helpType)));
  }

  void _onUpdateMood(UpdateMood event, Emitter<UserProfileState> emit) {
    final currentProfile = (state is UserProfileUpdated)
        ? (state as UserProfileUpdated).profile
        : UserProfile();
    emit(UserProfileUpdated(currentProfile.copyWith(mood: event.mood)));
  }

  void _onUpdateSleepHour(
      UpdateSleepHour event, Emitter<UserProfileState> emit) {
    final currentProfile = (state is UserProfileUpdated)
        ? (state as UserProfileUpdated).profile
        : UserProfile();
    emit(UserProfileUpdated(
        currentProfile.copyWith(sleepHour: event.sleepHour)));
  }

  Future<void> _onSaveUserProfile(
      SaveUserProfileEvent event, Emitter<UserProfileState> emit) async {
    if (state is UserProfileUpdated) {
      try {
        emit(UserProfileLoadingState());
        final UserProfile profile = (state as UserProfileUpdated).profile;
        await saveUserProfile(event.userId, profile);
        emit(UserProfileSaved());
      } catch (e) {
        emit(UserProfileError(e.toString()));
      }
    }
  }

  Future<void> _onLoadUserProfile(
      LoadUserProfile event, Emitter<UserProfileState> emit) async {
    try {
      emit(UserProfileLoadingState());
      final profile = await getUserProfile(event.userId);
      emit(UserProfileUpdated(profile as UserProfile));
    } catch (e) {
      emit(UserProfileError(e.toString()));
    }
  }
}
