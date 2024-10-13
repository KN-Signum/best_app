import 'package:flutter/material.dart';

import '../screens/home.dart';

class BaseLayout extends StatelessWidget {
  final Widget child; // zmienny element
  const BaseLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
       backgroundColor:  const Color.fromRGBO(244, 242, 238, 100),
      appBar: AppBar(
        leading: IconButton(
          // To jest ikonka home
          icon: const Icon(Icons.home),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor:  const Color.fromRGBO(244, 242, 238, 100), // to jest górny pasek menu z home
      ),
      body: Row(
        children: [
          Container(
            width: size.width * 0.05,
            color: const Color.fromRGBO(244, 242, 238, 100), // to jest boczny pasek
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  // To jest boczny pasek plusik
                  backgroundColor:   const Color.fromRGBO(216, 207, 238, 100),
                  child: IconButton(
                    onPressed: () {}, // Add functionality later
                    icon: const Icon(Icons.add),
                  ),
                ),
                SizedBox(height: size.height * 0.025),
                CircleAvatar(
                  // To jest boczny pasek komentarz
                  backgroundColor:   const Color.fromRGBO(216, 207, 238, 100),
                  child: IconButton(
                    onPressed: () {}, // Add functionality later
                    icon: const Icon(Icons.announcement),
                  ),
                ),
                SizedBox(height: size.height * 0.025),
                CircleAvatar(
                  // to jest boczny pasek konto (avatar)
                  backgroundImage:
                      const AssetImage('assets/images/user_image.jpg'),
                  child: IconButton(
                    onPressed: () {}, // Add functionality later
                    icon: const Icon(Icons.person, color: Colors.transparent),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
              ],
            ),
          ),
          SizedBox(
            // to jest po kliknięciu w ogłoszenie 
            width: size.width * 0.95, // Zmienny element
            child: child,
            // tutaj trzeba zrobić, żeby kolor był tylko przy wyświetlaniu tego okna  
          ),
        ],
      ),
    );
  }
}
