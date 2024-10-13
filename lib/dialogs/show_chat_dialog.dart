import 'package:flutter/material.dart';

void showChatDialog(BuildContext context) {
  bool isResponseReceived = false; // Kontrola, czy odpowiedź została otrzymana
  final TextEditingController textController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width *
                  0.6, // 60% szerokości ekranu
              height: MediaQuery.of(context).size.height *
                  0.6, // 60% wysokości ekranu
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Czat',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: textController,
                    minLines: 3, // Minimalna liczba wierszy
                    maxLines: 3, // Maksymalna liczba wierszy
                    decoration: const InputDecoration(
                      labelText: 'Twoja wiadomość',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Po kliknięciu przycisku zmień stan i pokaż odpowiedź
                      setState(() {
                        isResponseReceived = true;
                      });
                    },
                    child: const Text('Zatwierdź'),
                  ),
                  const SizedBox(height: 20),
                  if (isResponseReceived)
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            flex: 2,
                            child: Text(
                              'Odpowiedź:',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 3,
                            child: Container(
                              width: 100,
                              height: 100,
                              color: Colors.blue, // Przykładowy kafelek
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
