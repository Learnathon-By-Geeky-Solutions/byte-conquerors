class UserProfile {
  final String gender;
  final String helpType;
  final String mood;
  final int sleepHour;

  UserProfile({
    this.gender = '',
    this.helpType = '',
    this.mood = '',
    this.sleepHour = 8,
  });

  // Adding the copyWith method here
  UserProfile copyWith({
    String? gender,
    String? helpType,
    String? mood,
    int? sleepHour,
  }) {
    return UserProfile(
      gender: gender ?? this.gender,
      helpType: helpType ?? this.helpType,
      mood: mood ?? this.mood,
      sleepHour: sleepHour ?? this.sleepHour,
    );
  }
}
