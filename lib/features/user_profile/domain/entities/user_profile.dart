class UserProfile {
  final String id;
  final String gender;
  final String helpType;
  final String mood;
  final int sleepHour;

  UserProfile({
    this.id = '',
    this.gender = '',
    this.helpType = '',
    this.mood = '',
    this.sleepHour = 8,
  });

  // Adding the copyWith method here
  UserProfile copyWith({
    String? id,
    String? gender,
    String? helpType,
    String? mood,
    int? sleepHour,
  }) {
    return UserProfile(
      id: id ?? this.id,
      gender: gender ?? this.gender,
      helpType: helpType ?? this.helpType,
      mood: mood ?? this.mood,
      sleepHour: sleepHour ?? this.sleepHour,
    );
  }
}
