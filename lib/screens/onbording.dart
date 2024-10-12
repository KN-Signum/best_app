import 'package:flutter/material.dart';

void main() {
  runApp(OnBording());
}

class OnBording extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto', // Nowoczesny, profesjonalny font
        primarySwatch: Colors.purple,
        textTheme: TextTheme(
          headlineLarge: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
          headlineMedium: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black87),
          bodyLarge: TextStyle(fontSize: 18, color: Colors.grey[800]),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => OnboardingPage(),
      },
    );
  }
}

class OnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Sekcja nagłówka z gradientem
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

            // Sekcja z funkcjami
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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

            // Sekcja "O nas"
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'O nas',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Brain Bridge powstał, aby ułatwić proces poszukiwania promotora i partnera badawczego dla studentów i naukowców. Wierzymy, że współpraca jest kluczem do osiągania wybitnych wyników naukowych.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Nasza platforma umożliwia:',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '• Znalezienie promotora, który będzie wspierał Cię w tworzeniu pracy naukowej.\n'
                    '• Nawiązanie współpracy z innymi badaczami o podobnych zainteresowaniach.\n'
                    '• Wymianę wiedzy i pomysłów w bezpiecznym środowisku.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Dlaczego warto skorzystać z Brain Bridge?',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '• Ułatwiamy proces poszukiwania współpracowników.\n'
                    '• Oszczędzamy Twój czas, eliminując długie poszukiwania.\n'
                    '• Zwiększamy szanse na sukces naukowy dzięki skutecznej współpracy.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget Karty Onboarding
class OnboardingCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  OnboardingCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width < 600 ? size.width * 0.8 : size.width * 0.4, // Szerokość karty w zależności od ekranu
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
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
