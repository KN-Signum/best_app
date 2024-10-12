class Annoucment {
  final String title;
  final String authorName;
  final String description;
  final DateTime date; // Zmiana na DateTime
  final String image;

  Annoucment({
    required this.title,
    required this.authorName,
    required this.description,
    required this.date, // Używaj DateTime
    this.image = 'assets/images/user_image.jpg',
  });

  factory Annoucment.fromJson(Map<String, dynamic> json) {
    return Annoucment(
      authorName: json['authorName'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']), // Konwersja z String na DateTime
      image: json['image'],
    );
  }
}
