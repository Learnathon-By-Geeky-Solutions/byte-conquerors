abstract class UserProfileEvent {}

class UpdateGender extends UserProfileEvent {
  final String gender;
  UpdateGender(this.gender);
}

class UpdateHelpType extends UserProfileEvent {
  final String helpType;
  UpdateHelpType(this.helpType);
}

class UpdateMood extends UserProfileEvent {
  final String mood;
  UpdateMood(this.mood);
}

class UpdateSleepHour extends UserProfileEvent {
  final int sleepHour;
  UpdateSleepHour(this.sleepHour);
}

class SaveUserProfileEvent extends UserProfileEvent {
  final String userId;
  SaveUserProfileEvent(this.userId);
}

class LoadUserProfile extends UserProfileEvent {
  final String userId;
  LoadUserProfile(this.userId);
}
