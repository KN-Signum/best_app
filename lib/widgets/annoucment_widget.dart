import 'package:flutter/material.dart';
import '../model/annoucment.dart';

class AnnouncementTile extends StatelessWidget {
  final Annoucment announcement;

  const AnnouncementTile({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    // Formatting date
    String formattedDate = announcement.whenAdded;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 188, 177, 214),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and basic information
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: AssetImage("assets/images/user_image.jpg"), // Path to your image
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      announcement.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Added: $formattedDate | Location: ${announcement.location}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Work Type: ${announcement.workingType}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          // Project abstract
          Text(
            announcement.abstract,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12.0),
          // Project tags
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: announcement.tags
                .map((tag) => Chip(
                      label: Text(tag),
                      backgroundColor: Colors.blueGrey[100],
                    ))
                .toList(),
          ),
          const SizedBox(height: 12.0),
          // Project requirements
          Text(
            "Requirements:",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: announcement.requirements
                .map(
                  (requirement) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Row(
                      children: [
                        const Icon(Icons.check, size: 16.0, color: Colors.green),
                        const SizedBox(width: 6.0),
                        Expanded(
                          child: Text(
                            requirement,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 12.0),
          // Additional information about experience level
          Text(
            'Experience Level: ${announcement.levelOfExperience}',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
