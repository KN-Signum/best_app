import 'package:best_app/widgets/base_layout.dart';
import 'package:flutter/material.dart';
import 'package:best_app/data/mock_annoucments.dart';
import 'package:best_app/widgets/annoucment_widget.dart';

import '../model/annoucment.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Annoucment> announcements = mockAnnouncements;

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.225,
            color: Colors.blueGrey[500],
            // Zawartość zmienna, np. wyszukiwanie
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Wyszukiwanie', style: TextStyle(fontSize: 20)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Wyszukaj',
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    children: [
                      for (int i = 0; i < 21; i++)
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: CircleAvatar(
                            backgroundColor: Colors.blueGrey[300],
                            child: Center(
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.category),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blueGrey[600],
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 1,
                ),
                itemCount: announcements.length,
                itemBuilder: (context, index) {
                  return AnnouncementTile(
                    title: announcements[index].title,
                    authorName: announcements[index].authorName,
                    date: announcements[index].date,
                    description: announcements[index].description,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
