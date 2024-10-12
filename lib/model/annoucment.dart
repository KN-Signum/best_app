class Annoucment {
  final String id;
  final String title;
  final String abstract;
  final String fullText;
  final List<String> tags;
  final String owner;
  final String ownerId;
  final String ownerPicture;
  final String ownerType;
  final int views;
  final String whenAdded;
  final String location;
  final bool isActive;
  final String workingType;
  final String levelOfExperience;
  final List<String>
      requirements; // Zmiana nazwy z requiredSkills na requirements

  Annoucment({
    required this.id,
    required this.title,
    required this.abstract,
    required this.fullText,
    required this.tags,
    required this.owner,
    required this.ownerId,
    required this.ownerPicture,
    required this.ownerType,
    required this.views,
    required this.whenAdded,
    required this.location,
    required this.isActive,
    required this.workingType,
    required this.levelOfExperience,
    required this.requirements, // Zmiana
  });

  factory Annoucment.fromJson(Map<String, dynamic> json) {
    return Annoucment(
      id: json['id'] as String,
      title: json['title'] as String,
      abstract: json['abstract'] as String,
      fullText: json['full_text'] as String,
      tags: (json['tags'] as List).map((tag) => tag as String).toList(),
      owner: json['owner'] as String,
      ownerId: json['owner_id'] as String,
      ownerPicture: json['owner_picture'] as String,
      ownerType: json['owner_type'] as String,
      views: json['views'] as int,
      whenAdded: json['when_added'] as String,
      location: json['location'] as String,
      isActive: json['is_active'] as bool,
      workingType: json['working_type'] as String,
      levelOfExperience: json['level_of_experience'] as String,
      requirements: (json['requirements'] as List) // Zmiana
          .map((skill) => skill as String)
          .toList(),
    );
  }
}
