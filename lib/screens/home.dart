import 'package:best_app/widgets/annoucment_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
            width: size.width * 0.1,
            color: Colors.blueGrey[300],
          ),
          Container(
            width: size.width * 0.9,
            color: Colors.blueGrey[400],
            child: Column(
              children: [
                Container(
                  height: size.height * 0.225,
                  color: Colors.blueGrey[500],
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Wyszukiwanie',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[300],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Wyszukaj',
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          children: [
                            for (int i = 0; i < 21; i++)
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: CircleAvatar(
                                  backgroundColor: Colors.blueGrey[300],
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.category),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.blueGrey[600],
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, // 4 elementy w wierszu
                        crossAxisSpacing: 10.0, // Odstęp między kolumnami
                        mainAxisSpacing: 10.0, // Odstęp między wierszami
                        childAspectRatio: 1, // Proporcje elementów
                      ),
                      itemCount: 20, // Liczba elementów mockowo
                      itemBuilder: (context, index) {
                        return AnnouncementTile(
                            title: "title",
                            authorName: "authorName",
                            date: "date",
                            description:
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.");
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
