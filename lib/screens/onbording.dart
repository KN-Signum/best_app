import 'package:best_app/screens/auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Onboarding());
}

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

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
        '/login': (context) => const LoginScreen(),
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
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(size.width * 0.05),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade600, Colors.blueAccent.shade400],
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
                    'Connecting researchers, creating the future',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // About Us Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Why Brain Bridge?',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 20),

                  // About cards with icons
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AboutCardWithIcon(
                        icon: Icons.groups_outlined,
                        title: 'The Reason Behind',
                        description: 'Brain Bridge was created to help students and researchers find mentors and research collaborators.',
                      ),
                      AboutCardWithIcon(
                        icon: Icons.handyman_outlined,
                        title: 'What We Provide',
                        description: 'We offer tools that support effective collaboration on research projects.',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AboutCardWithIcon(
                        icon: Icons.timeline_outlined,
                        title: 'Why Choose Us?',
                        description: 'Brain Bridge saves your time and helps create effective research teams, increasing chances of academic success.',
                      ),
                      AboutCardWithIcon(
                        icon: Icons.lightbulb_outlined,
                        title: 'Our Vision',
                        description: 'Our goal is to build a bridge between researchers worldwide, supporting innovation and discovery.',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            
          
            // Login Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                width: size.width * 0.4,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: Colors.purple.shade800, // Darker button background
                  ),
                  child: const Text(
                    'Go to Login',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Widget AboutCardWithIcon for "About Us" section
class AboutCardWithIcon extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const AboutCardWithIcon({
    super.key,
    required this.icon,
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
          Icon(
            icon,
            size: size.height * 0.15,
            color: Colors.purpleAccent,
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

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: const Center(
        child: Text('Login Page'),
      ),
    );
  }
}
