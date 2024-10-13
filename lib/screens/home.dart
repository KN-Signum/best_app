import 'package:best_app/services/api_service.dart';
import 'package:best_app/widgets/base_layout.dart';
import 'package:flutter/material.dart';
import 'package:best_app/widgets/annoucment_widget.dart';
import 'package:intl/intl.dart';

import '../model/annoucment.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.userId});
  final String? userId;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ApiService apiService = ApiService();
  List<Annoucment> announcements = []; // Pełna lista ogłoszeń
  List<Annoucment> filteredAnnouncements = []; // Przefiltrowana lista ogłoszeń
  List<dynamic> myNotes = []; // Lista notatek
  String searchQuery = ""; // Przechowuje aktualne zapytanie wyszukiwania
  String selectedFilter = 'title'; // Domyślny filtr

  // Mapa filtrów z tłumaczeniem na język polski
  Map<String, String> filters = {
    'title': 'Tytuł',
    'owner': 'Właściciel',
    'tags': 'Tagi',
    'location': 'Lokalizacja',
    'working_type': 'Rodzaj pracy',
    'level_of_experience': 'Poziom doświadczenia',
    'requirements': 'Wymagania',
    'owner_type': 'Typ właściciela',
    'popularity': 'Popularność',
    'last_added': 'Ostatnio dodane',
  };

  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  bool isDetailView = false; // Zmienna, która kontroluje tryb szczegółowy
  Annoucment?
      selectedAnnouncement; // Wybrane ogłoszenie do wyświetlenia szczegółów

  @override
  void initState() {
    super.initState();
    loadAnnouncements(); // Pobieranie ogłoszeń z API
    loadMyNotes(); // Pobieranie notatek dla użytkownika
  }

  // Pobieranie notatek dla użytkownika
  void loadMyNotes() async {
    if (widget.userId != null) {
      List<dynamic> fetchedNotes =
          await apiService.getAllMyNotes(widget.userId!);
      setState(() {
        myNotes = fetchedNotes;
      });
      print('My notes: $myNotes');
    }
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
    final dateFormat = DateFormat('dd/MM/yyyy');

    announcements.sort((a, b) {
      DateTime dateA = dateFormat.parse(a.whenAdded);
      DateTime dateB = dateFormat.parse(b.whenAdded);
      return dateB
          .compareTo(dateA); // Sortowanie od najnowszych do najstarszych
    });
  }

  void _filterAnnouncements() async {
    try {
      // Wysyłamy zapytanie do API Service, przekazując typ filtra i zapytanie
      List<Annoucment> searchResults =
          await apiService.searchAnnouncements(selectedFilter, searchQuery);
      setState(() {
        filteredAnnouncements = searchResults;
      });
    } catch (e) {
      print('Błąd podczas wyszukiwania ogłoszeń: $e');
    }
  }

  // Zmiana widoku na szczegóły ogłoszenia
  void _showAnnouncementDetails(Annoucment announcement) {
    setState(() {
      isDetailView = true;
      selectedAnnouncement = announcement;
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
    var detailContent = selectedAnnouncement != null
        ? Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(selectedAnnouncement!.title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Autor: ${selectedAnnouncement!.owner}',
                        style: const TextStyle(fontSize: 16)),
                    Text('Data: ${selectedAnnouncement!.whenAdded}',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        AssetImage(selectedAnnouncement!.ownerPicture),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Opis:',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Text(selectedAnnouncement!.abstract,
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _messageController,
                  minLines: 5,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Napisz wiadomość do ogłoszeniodawcy',
                    labelStyle: TextStyle(),
                    fillColor: Color.fromRGBO(230, 225, 242, 1),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 237, 224, 219),
                          width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 237, 224, 219),
                          width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 237, 224, 219),
                          width: 2.0),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      String? ownerId = await ApiService()
                          .getUserByUsername(selectedAnnouncement!.owner);
                      if (ownerId != null) {
                        bool success = await ApiService().sendApplicationNote(
                          title: 'Aplikacja na ogłoszenie',
                          content: _messageController.text,
                          ownerId: widget.userId!,
                          sendToId: ownerId,
                        );

                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Notatka wysłana pomyślnie do właściciela ogłoszenia!')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Nie udało się wysłać notatki.')),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Nie udało się pobrać danych właściciela ogłoszenia.')),
                        );
                      }
                    },
                    child: const Text('Aplikuj'),
                  ),
                ),
              ],
            ),
          )
        : Container();

    return Scaffold(
    backgroundColor: const Color.fromARGB(156, 249, 249, 249),
      body: BaseLayout(
        userId: widget.userId,
        myNotes: myNotes,
        child: isDetailView
            ? detailContent
            : Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.02,
                      vertical: MediaQuery.of(context).size.height * 0.02,
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
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('      Announcements browser',
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
                              hintText: '      search announcements...',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value;
                                _filterAnnouncements();
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            children: [
                              SizedBox(width: 15),
                              const Text("  Filters: "),
                              DropdownButton<String>(
                                value: selectedFilter,
                                icon: const Icon(Icons.arrow_drop_down),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedFilter = newValue!;
                                    _filterAnnouncements();
                                  });
                                },
                                items: filters.entries.map((entry) {
                                  return DropdownMenuItem<String>(
                                    value: entry.key,
                                    child: Text(entry.value),
                                  );
                                }).toList(),
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
                          MediaQuery.of(context).size.width * 0.01),
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
