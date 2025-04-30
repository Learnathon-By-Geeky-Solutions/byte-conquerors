import 'package:equatable/equatable.dart';
import 'package:soul_space/features/user_profile/domain/entities/user_profile.dart';

abstract class UserProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileUpdated extends UserProfileState {
  final UserProfile profile;
  UserProfileUpdated(this.profile);

  @override
  List<Object?> get props => [profile];
}

class UserProfileSaved extends UserProfileState {}

class UserProfileError extends UserProfileState {
  final String message;
  UserProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class UserProfileLoadingState extends UserProfileState {}
