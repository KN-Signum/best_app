class UserToDb {
  final String name;
  final String surname;
  final String bio;
  final List<String> tags;
  final String email;
  final String username;
  final String profilePicture;
  final int howManyRequests;
  final String userType;
  final String academicalIndex;

  UserToDb({
    required this.name,
    required this.surname,
    required this.bio,
    required this.tags,
    required this.email,
    required this.username,
    required this.profilePicture,
    required this.howManyRequests,
    required this.userType,
    required this.academicalIndex,
  });

  factory UserToDb.fromJson(Map<String, dynamic> json) {
    return UserToDb(
      name: json['name'] as String,
      surname: json['second_name'] as String,
      bio: json['bio'] as String,
      tags: (json['tags'] as List).map((tag) => tag as String).toList(),
      email: json['email'] as String,
      username: json['username'] as String,
      profilePicture: json['profile_picture'] as String,
      howManyRequests: json['how_many_requests'] as int,
      userType: json['user_type'] as String,
      academicalIndex: json['academical_index'] as String,
    );
  }
}
