import 'package:flutter/material.dart';

void showAplicationDialog(BuildContext context, List<dynamic> myNotes) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.7,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Zgłoszenia',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: myNotes.length,
                  itemBuilder: (context, index) {
                    var note = myNotes[index];
                    return ExpansionTile(
                      title: Text(
                        note['title'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Zgłoszone przez: ${note['from']}'),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(note['content']),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              // Tutaj możesz dodać akcję kontaktu, np. przekierowanie do czatu lub wysłania maila
                              Navigator.of(context).pop(); // Zamyka dialog
                            },
                            child: const Text('Kontakt'),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Zamyka dialog
                  },
                  child: const Text('Zamknij'),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
