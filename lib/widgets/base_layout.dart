import 'package:flutter/material.dart';

import '../dialogs/add_annoucments_dialog.dart';
import '../screens/home.dart';
import '../services/api_service.dart';

class BaseLayout extends StatelessWidget {
  final Widget child; // zmienny element
  const BaseLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 242, 238, 100),
      appBar: AppBar(
        leading: IconButton(
            // to jest ikonka home
            icon: const Icon(Icons.home),
            onPressed: () {}
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => Home(),
            //   ),
            // ),
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
                      showAddAnnouncementDialog(context, (newAnnouncement) {
                        // Przykładowe użycie: zapisanie ogłoszenia lub wywołanie API
                        ApiService().addAnnoucment(newAnnouncement);
                      });
                    }, // Add functionality later
                    icon: const Icon(Icons.add),
                  ),
                ),
                SizedBox(height: size.height * 0.025),
                CircleAvatar(
                  backgroundColor: const Color.fromRGBO(216, 207, 238, 100),
                  child: IconButton(
                    onPressed: () {}, // Add functionality later
                    icon: const Icon(Icons.announcement),
                  ),
                ),
                SizedBox(height: size.height * 0.025),
                CircleAvatar(
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
          Container(
            width: size.width * 0.95, // Zmienny element
            child: child,
          ),
        ],
      ),
    );
  }
}
