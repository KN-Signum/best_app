import 'package:flutter/material.dart';
import '../model/annoucment.dart';

class AnnouncementTile extends StatelessWidget {
  final Annoucment announcement; // Zmienna przechowująca ogłoszenie

  AnnouncementTile({required this.announcement});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double cardHeight = screenHeight / 6; // Możesz dostosować wysokość
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = screenWidth;

    // Formatowanie daty
    String formattedDate = announcement.whenAdded;

    return Container(
      margin: const EdgeInsets.only(top: 4.0),
      height: cardHeight,
      width: cardWidth,
      child: Card(
        color: const Color.fromRGBO(230, 225, 242, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                backgroundImage: AssetImage(announcement.ownerPicture),
              ),
              title: Text(announcement.title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Właściciel: ${announcement.owner} (${announcement.ownerType})'),
                  Text('Lokalizacja: ${announcement.location}'),
                  Text('Dodano: $formattedDate',
                      style: const TextStyle(fontSize: 12)),
                  Text('Wyświetlenia: ${announcement.views}'),
                  const SizedBox(height: 4.0),
                  Wrap(
                    spacing: 6.0,
                    children: announcement.tags
                        .map((tag) => Chip(
                              label: Text(tag),
                              backgroundColor: Colors.blueGrey[100],
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(announcement.abstract,
                  maxLines: 2, overflow: TextOverflow.ellipsis),
            ),

            // Informacja o typie pracy
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Text('Rodzaj pracy: ${announcement.workingType}'),
            ),
            // Doświadczenie
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Text('Doświadczenie: ${announcement.levelOfExperience}'),
            ),
          ],
        ),
      ),
    );
  }
}
