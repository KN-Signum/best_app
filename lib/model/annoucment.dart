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
  final String whenAdded;
  final String location;
  final String workingType;
  final String levelOfExperience;
  final List<String> requirements;

  // Poprawka dla `views` - obsługa null
  final int? views; // Teraz jest nullable

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
    required this.whenAdded,
    required this.location,
    required this.workingType,
    required this.levelOfExperience,
    required this.requirements,
    this.views, // Teraz nullable
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
      whenAdded: json['when_added'] as String,
      location: json['location'] as String,
      workingType: json['working_type'] as String,
      levelOfExperience: json['level_of_experience'] as String,
      requirements:
          (json['requirements'] as List).map((req) => req as String).toList(),
      views: json['views'] != null ? json['views'] as int : 0, // Obsługa null
    );
  }
}
