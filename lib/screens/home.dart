import 'package:best_app/services/api_service.dart';
import 'package:best_app/widgets/base_layout.dart';
import 'package:flutter/material.dart';
import 'package:best_app/widgets/annoucment_widget.dart';
import 'package:intl/intl.dart';

import '../model/annoucment.dart';

class Home extends StatefulWidget {
  Home({super.key, required this.userId});
  final String? userId;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ApiService apiService = ApiService();
  List<Annoucment> announcements = []; // Pełna lista ogłoszeń
  List<Annoucment> filteredAnnouncements = []; // Przefiltrowana lista ogłoszeń
  String searchQuery = ""; // Przechowuje aktualne zapytanie wyszukiwania

  final TextEditingController _searchController = TextEditingController();

  bool isDetailView = false; // Zmienna, która kontroluje tryb szczegółowy
  Annoucment?
      selectedAnnouncement; // Wybrane ogłoszenie do wyświetlenia szczegółów

  @override
  void initState() {
    super.initState();
    loadAnnouncements(); // Pobieranie ogłoszeń z API
  }

  // Pobieranie ogłoszeń z API
  void loadAnnouncements() async {
    try {
      List<Annoucment> fetchedAnnouncements = await apiService.getAnnoucments();
      setState(() {
        announcements = fetchedAnnouncements;
        filteredAnnouncements = announcements;
        _sortAnnouncementsByDate(); // Sortowanie domyślne
      });
    } catch (e) {
      print('Błąd podczas pobierania ogłoszeń: $e');
    }
  }

  // Sortowanie ogłoszeń od najnowszych do najstarszych
  void _sortAnnouncementsByDate() {
    // Użycie DateFormat do parsowania daty
    final dateFormat = DateFormat('dd/MM/yyyy');

    announcements.sort((a, b) {
      DateTime dateA = dateFormat.parse(a.whenAdded); // Parsowanie a.whenAdded
      DateTime dateB = dateFormat.parse(b.whenAdded); // Parsowanie b.whenAdded
      return dateB
          .compareTo(dateA); // Sortowanie od najnowszych do najstarszych
    });
  }

  // Funkcja do filtrowania ogłoszeń na podstawie zapytania wyszukiwania
  void _filterAnnouncements() {
    setState(() {
      filteredAnnouncements = announcements.where((announcement) {
        return announcement.title
                .toLowerCase()
                .contains(searchQuery.toLowerCase()) ||
            announcement.abstract
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
              // Informacje o właścicielu i dacie
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Autor: ${selectedAnnouncement!.owner}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Data: ${selectedAnnouncement!.whenAdded}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Obrazek autora lub ogłoszenia
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      AssetImage(selectedAnnouncement!.ownerPicture),
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
                selectedAnnouncement!.abstract,
                style: const TextStyle(fontSize: 16),
              ),
              const Spacer(),
            ],
          )
        : Container();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 242, 238, 100),
      body: BaseLayout(
        child: isDetailView
            ? detailContent // Wyświetl szczegóły ogłoszenia
            : Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width *
                          0.02, // 5% szerokości ekranu jako margines
                      vertical: MediaQuery.of(context).size.height *
                          0.02, // 2% wysokości ekranu jako margines
                    ),
                    height: MediaQuery.of(context).size.height * 0.225,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(230, 225, 242, 1),
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          color: Colors.transparent,
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
                            color: const Color.fromRGBO(216, 207, 238, 100),
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
                          color: Colors.transparent,
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
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.02),
                      color: const Color.fromRGBO(244, 242, 238, 100),
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
                                announcement: filteredAnnouncements[index]),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
