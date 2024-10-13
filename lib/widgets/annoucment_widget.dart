import 'package:flutter/material.dart';
import '../model/annoucment.dart';

class AnnouncementTile extends StatelessWidget {
  final Annoucment announcement;

  const AnnouncementTile({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    // Formatowanie daty
    String formattedDate = announcement.whenAdded;

    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.all(8.0),
      height: 140,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(230, 225, 242, 1),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            announcement.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Divider(
            color: Colors.black,
            thickness: 1,
          ),
          Text(
            announcement.abstract,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10.0),
          // Właściciel ogłoszenia i avatar
          Row(
            children: [
              const CircleAvatar(
                radius: 20.0,
                backgroundImage: AssetImage("images/user_image.jpg"),
              ),
              const SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    announcement.owner,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    formattedDate,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
