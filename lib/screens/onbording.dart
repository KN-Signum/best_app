import 'package:flutter/material.dart';

void main() {
  runApp(const OnBording());
}

class OnBording extends StatelessWidget {
  const OnBording({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.purple,
        textTheme: TextTheme(
          headlineLarge: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
          headlineMedium: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black87),
          bodyLarge: TextStyle(fontSize: 18, color: Colors.grey[800]),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardingPage(),
      },
    );
  }
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Nagłówek
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(size.width * 0.05),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade400, Colors.blueAccent.shade200],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Brain Bridge',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Łączymy badaczy, tworzymy przyszłość',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Sekcja "Funkcje"
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Wrap(
                spacing: 30.0,
                runSpacing: 30.0,
                alignment: WrapAlignment.center,
                children: [
                  OnboardingCard(
                    icon: Icons.lightbulb_outline,
                    title: 'Innowacyjne rozwiązania',
                    description: 'Nowoczesne narzędzia do ułatwienia współpracy.',
                  ),
                  OnboardingCard(
                    icon: Icons.people_outline,
                    title: 'Zespół badawczy',
                    description: 'Znajdź promotora i partnera do pracy naukowej.',
                  ),
                  OnboardingCard(
                    icon: Icons.security,
                    title: 'Bezpieczeństwo',
                    description: 'Twoje dane są bezpieczne i poufne.',
                  ),
                  OnboardingCard(
                    icon: Icons.support,
                    title: 'Wsparcie 24/7',
                    description: 'Wsparcie o każdej porze, gdy tego potrzebujesz.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Kreatywna sekcja "O nas"
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Dlaczego Brain Bridge?',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 20),

                  // Dodanie obrazków i tekstów w stylu kart
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AboutCard(
                        imagePath: 'https://example.com/teamwork.png',
                        title: 'Powód powstania',
                        description: 'Brain Bridge powstał, aby ułatwić studentom i naukowcom odnalezienie promotorów oraz współpracowników badawczych.',
                      ),
                      AboutCard(
                        imagePath: 'https://example.com/tools.png',
                        title: 'Co umożliwiamy',
                        description: 'Oferujemy narzędzia, które wspierają efektywną współpracę nad projektami badawczymi.',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AboutCard(
                        imagePath: 'https://example.com/success.png',
                        title: 'Dlaczego warto?',
                        description: 'Brain Bridge oszczędza Twój czas i pomaga w tworzeniu efektywnych zespołów badawczych, zwiększając szanse na sukces naukowy.',
                      ),
                      AboutCard(
                        imagePath: 'https://example.com/innovation.png',
                        title: 'Nasza wizja',
                        description: 'Naszym celem jest zbudowanie mostu pomiędzy naukowcami na całym świecie, wspierając innowacje i badania.',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// Widget OnboardingCard
class OnboardingCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const OnboardingCard({super.key, 
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width < 600 ? size.width * 0.8 : size.width * 0.4,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: size.width * 0.1,
            color: Colors.purpleAccent,
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

// Widget AboutCard do sekcji "O nas"
class AboutCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const AboutCard({super.key, 
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width < 600 ? size.width * 0.8 : size.width * 0.35,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            imagePath,
            height: size.height * 0.15,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
