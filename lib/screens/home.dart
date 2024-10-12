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
  List<Annoucment> announcements = mockAnnouncements; // Pełna lista ogłoszeń
  List<Annoucment> filteredAnnouncements = []; // Przefiltrowana lista ogłoszeń
  String searchQuery = ""; // Przechowuje aktualne zapytanie wyszukiwania

  final TextEditingController _searchController = TextEditingController();

  bool isDetailView = false; // Zmienna, która kontroluje tryb szczegółowy
  Annoucment?
      selectedAnnouncement; // Wybrane ogłoszenie do wyświetlenia szczegółów

  @override
  void initState() {
    super.initState();
    _sortAnnouncementsByDate(); // Domyślne sortowanie według daty
    filteredAnnouncements = announcements; // Inicjalnie pełna lista
  }

  // Sortowanie ogłoszeń od najnowszych do najstarszych
  void _sortAnnouncementsByDate() {
    announcements.sort((a, b) => b.date.compareTo(a.date));
  }

  // Funkcja do filtrowania ogłoszeń na podstawie zapytania wyszukiwania
  void _filterAnnouncements() {
    setState(() {
      // Filtruj po tytule i opisie na podstawie zapytania wyszukiwania
      filteredAnnouncements = announcements.where((announcement) {
        return announcement.title
                .toLowerCase()
                .contains(searchQuery.toLowerCase()) ||
            announcement.description
                .toLowerCase()
                .contains(searchQuery.toLowerCase());
      }).toList();
    });
  }

  // Zmiana widoku na szczegóły ogłoszenia
  void _showAnnouncementDetails(Annoucment announcement) {
    setState(() {
      isDetailView = true;
      selectedAnnouncement = announcement; // Przekazanie wybranego ogłoszenia
    });
  }

  // Powrót do widoku listy ogłoszeń
  void _goBackToList() {
    setState(() {
      isDetailView = false;
      selectedAnnouncement = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Layout szczegółów ogłoszenia
    var detailContent = selectedAnnouncement != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tytuł ogłoszenia
              Text(
                selectedAnnouncement!.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Informacje o autorze i dacie
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Autor: ${selectedAnnouncement!.authorName}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Data: ${selectedAnnouncement!.date.day}/${selectedAnnouncement!.date.month}/${selectedAnnouncement!.date.year}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Obrazek autora lub ogłoszenia
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(selectedAnnouncement!.image),
                ),
              ),
              const SizedBox(height: 20),
              // Opis ogłoszenia
              const Text(
                'Opis:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                selectedAnnouncement!.description,
                style: const TextStyle(fontSize: 16),
              ),
              const Spacer(),
            ],
          )
        : Container();

    return BaseLayout(
      child: isDetailView
          ? detailContent // Wyświetl szczegóły ogłoszenia
          : Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.225,
                  color: Colors.blueGrey[500],
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Wyszukiwanie',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[300],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            hintText: '  Wyszukaj',
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                            border: InputBorder.none, // Usuwa podkreślenie
                          ),
                          onChanged: (value) {
                            setState(() {
                              searchQuery =
                                  value; // Aktualizuj zapytanie wyszukiwania
                              _filterAnnouncements(); // Filtruj ogłoszenia
                            });
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          children: [
                            for (int i = 0; i < 21; i++)
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: CircleAvatar(
                                  backgroundColor: Colors.blueGrey[300],
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () {
                                        // Możliwość dodania filtrów w przyszłości
                                      },
                                      icon: const Icon(Icons.category),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.blueGrey[600],
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 1,
                      ),
                      itemCount: filteredAnnouncements.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            _showAnnouncementDetails(
                                filteredAnnouncements[index]);
                          },
                          child: AnnouncementTile(
                            title: filteredAnnouncements[index].title,
                            authorName: filteredAnnouncements[index].authorName,
                            date: filteredAnnouncements[index].date,
                            description:
                                filteredAnnouncements[index].description,
                          ),
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
