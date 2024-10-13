import 'package:flutter/material.dart';
import 'package:best_app/model/annoucmentToDb.dart';
import '../screens/home.dart';
import '../services/api_service.dart';

void showAddAnnouncementDialog(BuildContext context, String? userId) {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController abstractController = TextEditingController();
  final TextEditingController fullTextController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();
  final TextEditingController workingTypeController = TextEditingController();
  final TextEditingController levelOfExperienceController =
      TextEditingController();
  final TextEditingController requirementsController = TextEditingController();

  bool isActive = true; // Przełącznik stanu ogłoszenia (aktywne lub nieaktywne)

  // Funkcja do wysłania ogłoszenia
  void submitAnnouncement(AnnoucmentToDb annoucment) async {
    bool success = await ApiService().addAnnouncement(annoucment);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ogłoszenie zostało dodane!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nie udało się dodać ogłoszenia.')),
      );
    }
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      final Size size = MediaQuery.of(context).size;

      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: size.width * 0.6,
          height: size.height * 0.8,
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Dodaj nowe ogłoszenie',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Tytuł'),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: abstractController,
                  decoration: const InputDecoration(labelText: 'Streszczenie'),
                  maxLines: 2,
                  minLines: 2,
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: fullTextController,
                  decoration: const InputDecoration(labelText: 'Pełny tekst'),
                  minLines: 4,
                  maxLines: 4,
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: locationController,
                  decoration: const InputDecoration(labelText: 'Lokalizacja'),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: tagsController,
                  decoration: const InputDecoration(
                    labelText: 'Tagi (oddzielone przecinkami)',
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: workingTypeController,
                  decoration: const InputDecoration(
                    labelText: 'Rodzaj pracy (FullTime/PartTime)',
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: levelOfExperienceController,
                  decoration: const InputDecoration(
                    labelText: 'Poziom doświadczenia (Entry/Mid/Senior)',
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: requirementsController,
                  decoration: const InputDecoration(
                    labelText: 'Wymagania (oddzielone przecinkami)',
                  ),
                ),
                const SizedBox(height: 5),
                SwitchListTile(
                  title: const Text('Aktywne ogłoszenie'),
                  value: isActive,
                  onChanged: (bool value) {
                    isActive = value;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Anuluj'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Tworzenie obiektu AnnoucmentToDb z danych formularza
                        AnnoucmentToDb newAnnouncement = AnnoucmentToDb(
                          title: titleController.text,
                          abstract: abstractController.text,
                          fullText: fullTextController.text,
                          tags: tagsController.text
                              .split(',')
                              .map((tag) => tag.trim())
                              .toList(),
                          ownerId: userId!, // Przekazanie userId
                          location: locationController.text,
                          workingType: workingTypeController.text,
                          levelOfExperience: levelOfExperienceController.text,
                          requirements: requirementsController.text
                              .split(',')
                              .map((req) => req.trim())
                              .toList(),
                        );

                        // Wywołanie funkcji submitAnnouncement do wysłania ogłoszenia do API
                        submitAnnouncement(newAnnouncement);

                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => Home(userId: userId)),
                        );
                      },
                      child: const Text('Dodaj'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
