import 'package:flutter/material.dart';

class AnnouncementTile extends StatelessWidget {
  final String title;
  final String authorName;
  final String date;
  final String imageUrl;
  final String description;

  AnnouncementTile({
    required this.title,
    required this.authorName,
    required this.date,
    this.imageUrl = 'assets/images/user_image.jpg',
    required this.description,
  });

  get onTap => null;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double cardHeight = screenHeight / 7;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = screenWidth;

    return Container(
      margin: const EdgeInsets.only(top: 4.0),
      height: cardHeight,
      width: cardWidth,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 20.0,
                backgroundImage: AssetImage('assets/images/user_image.jpg'),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: Text(title),
              subtitle: Text(authorName),
              onTap: onTap,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(description),
            ),
          ],
        ),
      ),
    );
  }
}
