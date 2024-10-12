import 'package:flutter/material.dart';

void showAddAnnouncementDialog(
    BuildContext context, Function(String, String, String, String) onAdd) {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController authorNameController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Dodaj nowe ogłoszenie'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Tytuł'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Opis'),
            ),
            TextField(
              controller: dateController,
              decoration: const InputDecoration(labelText: 'Data'),
            ),
            TextField(
              controller: authorNameController,
              decoration: const InputDecoration(labelText: 'Autor'),
            ),
          ],
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
              onAdd(
                titleController.text,
                descriptionController.text,
                dateController.text,
                authorNameController.text,
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
