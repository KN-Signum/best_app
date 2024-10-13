import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Zakładam, że masz dostęp do ApiService

void showChatDialog(BuildContext context) {
  bool isResponseReceived = false; // Kontrola, czy odpowiedź została otrzymana
  bool isLoading = false; // Kontrola ładowania odpowiedzi
  String aiResponse = ''; // Przechowywanie odpowiedzi AI
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
                    'Chat with AI',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: textController,
                    minLines: 3, // Minimalna liczba wierszy
                    maxLines: 3, // Maksymalna liczba wierszy
                    decoration: const InputDecoration(
                      labelText: 'Your message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      // Uruchomienie stanu ładowania
                      setState(() {
                        isLoading = true;
                        isResponseReceived = false;
                        aiResponse = '';
                      });

                      // Wywołanie API
                      String response =
                          await ApiService().askAi(textController.text);

                      // Po otrzymaniu odpowiedzi, zmieniamy stan i pokazujemy wynik
                      setState(() {
                        isResponseReceived = true;
                        isLoading = false;
                        aiResponse = response;
                      });
                    },
                    child: const Text('Apply'),
                  ),
                  const SizedBox(height: 20),
                  // Sekcja ładowania lub wyświetlania odpowiedzi
                  if (isLoading)
                    const Center(
                      child:
                          CircularProgressIndicator(), // Pokazujemy loader podczas ładowania
                    )
                  else if (isResponseReceived)
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 2,
                            child: Text(
                              'Response:',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                aiResponse, // Wyświetlamy odpowiedź z API
                                style: const TextStyle(fontSize: 16),
                              ),
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
