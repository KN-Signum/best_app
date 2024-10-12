class Annoucment {
  final String title;
  final String authorName;
  final String description;
  final String date;
  final String image;

  Annoucment(
      {required this.title,
      required this.authorName,
      required this.description,
      required this.date,
      this.image = 'assets/images/user_image.jpg'});

  factory Annoucment.fromJson(Map<String, dynamic> json) {
    return Annoucment(
      authorName: json['authorName'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
      image: json['image'],
    );
  }
}
