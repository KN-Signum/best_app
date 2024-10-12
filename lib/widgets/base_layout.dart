import 'package:flutter/material.dart';

class BaseLayout extends StatelessWidget {
  final Widget child; // zmienny element
  const BaseLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {},
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: Row(
        children: [
          Container(
            width: size.width * 0.05,
            color: Colors.blueGrey[300],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  child: IconButton(
                    onPressed: () {}, // Add functionality later
                    icon: const Icon(Icons.add),
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
