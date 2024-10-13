class AnnoucmentToDb {
  final String title;
  final String abstract;
  final String fullText;
  final List<String> tags;
  final String ownerId;
  final String location;
  final String workingType;
  final String levelOfExperience;
  final List<String>
      requirements; // Zmiana nazwy z requiredSkills na requirements

  AnnoucmentToDb({
    required this.title,
    required this.abstract,
    required this.fullText,
    required this.tags,
    required this.ownerId,
    required this.location,
    required this.workingType,
    required this.levelOfExperience,
    required this.requirements, // Zmiana
  });

  factory AnnoucmentToDb.fromJson(Map<String, dynamic> json) {
    return AnnoucmentToDb(
      title: json['title'] as String,
      abstract: json['abstract'] as String,
      fullText: json['full_text'] as String,
      tags: (json['tags'] as List).map((tag) => tag as String).toList(),
      ownerId: json['owner_id'] as String,
      location: json['location'] as String,
      workingType: json['working_type'] as String,
      levelOfExperience: json['level_of_experience'] as String,
      requirements: (json['requirements'] as List) // Zmiana
          .map((skill) => skill as String)
          .toList(),
    );
  }
}
