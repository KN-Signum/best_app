import 'package:flutter/material.dart';
import '../dialogs/add_annoucments_dialog.dart';
import '../dialogs/show_application_dialog.dart';
import '../dialogs/show_chat_dialog.dart';
import '../screens/home.dart';

class BaseLayout extends StatelessWidget {
  final Widget child; // zmienny element
  final String? userId; // Dodanie pola userId
  final List<dynamic> myNotes; // Lista notatek

  const BaseLayout(
      {super.key,
      required this.child,
      required this.userId,
      required this.myNotes});
  // Konstruktor przyjmujący userId
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    bool hasNotes = myNotes.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 242, 238, 100),
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/images/logo.png',
            width: 30, // Możesz dostosować rozmiar
            height: 30,
            fit: BoxFit.cover,
          ),

          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) =>
                    Home(userId: userId)), // Przejście do Home
          ), // Funkcjonalność do przycisku Home
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(244, 242, 238, 100),
      ),
      body: Row(
        children: [
          Container(
            width: size.width * 0.05,
            color: const Color.fromRGBO(244, 242, 238, 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  backgroundColor: const Color.fromRGBO(216, 207, 238, 100),
                  child: IconButton(
                    onPressed: () {
                      // Wywołanie dialogu dodawania ogłoszeń z przekazaniem userId
                      showAddAnnouncementDialog(context, userId);
                    },
                    icon: const Icon(Icons.add),
                  ),
                ),
                SizedBox(height: size.height * 0.025),
                CircleAvatar(
                  backgroundColor: hasNotes
                      ? Colors
                          .green // Zmieniony kolor ikony, jeśli są wiadomości
                      : const Color.fromRGBO(216, 207, 238, 100),
                  child: IconButton(
                    onPressed: () {
                      showAplicationDialog(context, myNotes);
                    }, // Funkcjonalność dla ikony ogłoszeń
                    icon: const Icon(Icons.announcement),
                  ),
                ),
                SizedBox(height: size.height * 0.025),
                CircleAvatar(
                  backgroundImage:
                      const AssetImage('assets/images/user_image.jpg'),
                  child: IconButton(
                    onPressed: () {
                      showChatDialog(context);
                    }, // Funkcjonalność dla ikony użytkownika
                    icon: const Icon(Icons.person, color: Colors.transparent),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
              ],
            ),
          ),
          SizedBox(
            width: size.width * 0.95, // Zmienny element
            child: child,
          ),
        ],
      ),
    );
  }
}
