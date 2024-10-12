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
      return AlertDialog(
        title: const Text('Dodaj nowe ogłoszenie'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Tytuł'),
              ),
              TextField(
                controller: abstractController,
                decoration: const InputDecoration(labelText: 'Streszczenie'),
              ),
              TextField(
                controller: fullTextController,
                decoration: const InputDecoration(labelText: 'Pełny tekst'),
              ),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(labelText: 'Lokalizacja'),
              ),
              TextField(
                controller: ownerController,
                decoration: const InputDecoration(labelText: 'Właściciel'),
              ),
              TextField(
                controller: tagsController,
                decoration: const InputDecoration(
                    labelText: 'Tagi (oddzielone przecinkami)'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Anuluj'),
          ),
          TextButton(
            onPressed: () {
              // Przekazanie wprowadzonego ogłoszenia do funkcji onAdd
              onAdd(
                Annoucment(
                  id: UniqueKey().toString(), // Generowanie unikalnego ID
                  title: titleController.text,
                  abstract: abstractController.text,
                  fullText: fullTextController.text,
                  tags: tagsController.text
                      .split(',')
                      .map((tag) => tag.trim())
                      .toList(),
                  owner: ownerController.text,
                  ownerId: 'unknown', // Można ustawić właściciela jako domyślny
                  ownerPicture:
                      'default.jpg', // Przykładowa wartość dla zdjęcia
                  ownerType: 'Student', // Domyślnie jako student
                  views: 0, // Domyślna wartość wyświetleń
                  whenAdded: DateTime.now().toIso8601String(), // Bieżąca data
                  location: locationController.text,
                  isActive: true, // Nowe ogłoszenia są domyślnie aktywne
                  workingType: 'FullTime', // Domyślny typ pracy
                  levelOfExperience: 'Entry', // Domyślny poziom doświadczenia
                  requirements: [], // Puste wymagania na razie
                ),
              );
              Navigator.of(context).pop();
            },
            child: const Text('Dodaj'),
          ),
        ],
      );
    },
  );
}
