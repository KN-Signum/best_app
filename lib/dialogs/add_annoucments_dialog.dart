import 'package:flutter/material.dart';
import 'package:best_app/model/annoucment.dart';

void showAddAnnouncementDialog(
    BuildContext context, Function(Annoucment) onAdd) {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController abstractController = TextEditingController();
  final TextEditingController fullTextController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController ownerController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      final Size size =
          MediaQuery.of(context).size; // Pobieranie rozmiaru ekranu

      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: size.width *
              0.6, // Zwiększenie szerokości do 60% szerokości ekranu
          height: size.height *
              0.7, // Zwiększenie wysokości do 70% wysokości ekranu
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dodaj nowe ogłoszenie',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(labelText: 'Tytuł'),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: abstractController,
                        decoration:
                            const InputDecoration(labelText: 'Streszczenie'),
                        maxLines: 2, // Streszczenie na maksymalnie dwa wiersze
                        minLines: 2,
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: fullTextController,
                        decoration:
                            const InputDecoration(labelText: 'Pełny tekst'),
                        minLines: 4,
                        maxLines:
                            4, // Pełny tekst na maksymalnie cztery wiersze
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: locationController,
                        decoration:
                            const InputDecoration(labelText: 'Lokalizacja'),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: ownerController,
                        decoration:
                            const InputDecoration(labelText: 'Właściciel'),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: tagsController,
                        decoration: const InputDecoration(
                          labelText: 'Tagi (oddzielone przecinkami)',
                        ),
                      ),
                    ],
                  ),
                ),
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
                      // Przekazanie wprowadzonego ogłoszenia do funkcji onAdd
                      onAdd(
                        Annoucment(
                          id: UniqueKey()
                              .toString(), // Generowanie unikalnego ID
                          title: titleController.text,
                          abstract: abstractController.text,
                          fullText: fullTextController.text,
                          tags: tagsController.text
                              .split(',')
                              .map((tag) => tag.trim())
                              .toList(),
                          owner: ownerController.text,
                          ownerId:
                              'unknown', // Można ustawić właściciela jako domyślny
                          ownerPicture:
                              'default.jpg', // Przykładowa wartość dla zdjęcia
                          ownerType: 'Student', // Domyślnie jako student
                          views: 0, // Domyślna wartość wyświetleń
                          whenAdded:
                              DateTime.now().toIso8601String(), // Bieżąca data
                          location: locationController.text,
                          isActive:
                              true, // Nowe ogłoszenia są domyślnie aktywne
                          workingType: 'FullTime', // Domyślny typ pracy
                          levelOfExperience:
                              'Entry', // Domyślny poziom doświadczenia
                          requirements: [], // Puste wymagania na razie
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                    child: const Text('Dodaj'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
