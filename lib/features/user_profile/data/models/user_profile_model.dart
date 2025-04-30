class UserProfileModel {
  final int id;
  final String gender;
  final String helpType;
  final String mood;
  final int sleepHour;

  UserProfileModel({
    required this.id,
    required this.gender,
    required this.helpType,
    required this.mood,
    required this.sleepHour,
  });

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'helpType': helpType,
      'mood': mood,
      'sleepHour': sleepHour,
    };
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'],
      gender: json['gender'],
      helpType: json['helpType'],
      mood: json['mood'],
      sleepHour: json['sleepHour'],
    );
  }
}
