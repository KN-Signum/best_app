import 'package:flutter/material.dart';

import '../model/user.dart';
import '../services/api_service.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;
  int _currentStep = 0;

  // Dane formularza
  String? _login,
      _email,
      _password,
      _confirmPassword,
      _firstName,
      _lastName,
      _phoneNumber,
      _bio; // Dodaj bio
  List<String> _tags = []; // Dodaj tagi (domyślnie pusta lista)

  // Metoda do obsługi zakończenia rejestracji
  void _submitRegistration() async {
    if (_password != _confirmPassword) {
      // Zgłoś błąd, jeśli hasła się nie zgadzają
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hasła muszą się zgadzać!')),
      );
      return;
    }

    // Stwórz użytkownika na podstawie wprowadzonych danych
    UserToDb newUser = UserToDb(
      name: _firstName ?? '',
      surname: _lastName ?? '',
      bio: _bio ?? 'Użytkownik nie podał bio.', // Przykładowy bio
      tags: _tags.isNotEmpty
          ? _tags
          : ['General'], // Przykładowe tagi, jeśli brak
      email: _email ?? '',
      username: _login ?? '',
      profilePicture: 'default_profile', // Przykładowy obraz
      howManyRequests: 0, // Domyślnie zero zapytań
      userType: 'Student', // Domyślny typ użytkownika
      academicalIndex: 'N/A', // Domyślna wartość indeksu akademickiego
    );

    // Wywołanie API do stworzenia użytkownika
    bool success = await ApiService().createUser(newUser, _password ?? '');

    if (success) {
      String? userId = await ApiService().getUserByUsername(_login!);
      // Po pomyślnej rejestracji, przejdź do strony Home
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => Home(
                  userId: userId,
                )), // Przejście do Home
      );
    } else {
      // Obsługa błędu
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rejestracja nie powiodła się.')),
      );
    }
  }

  // Metoda do obsługi logowania
  void _submitLogin() async {
    if (_login == null || _password == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Proszę wprowadzić login i hasło.')),
      );
      return;
    }

    // Wywołanie API do walidacji użytkownika
    bool success = await ApiService().validateUser(_login!, _password!);

    if (success) {
      String? userId = await ApiService().getUserByUsername(_login!);
      // Po pomyślnej walidacji, przejdź do strony Home
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => Home(userId: userId)), // Przejście do Home
      );
    } else {
      // Obsługa błędu
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Niepoprawne dane logowania.')),
      );
    }
  }

  // Widget do budowania pól tekstowych
  Widget _buildTextField({
    required String hintText,
    bool isPassword = false,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.blueGrey[100],
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        ),
        onChanged: onChanged,
      ),
    );
  }

  // Widget do wyświetlania podsumowania danych w przeglądzie
  Widget _buildReviewRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value ?? '-'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.width < 600;

    // Zmienna content zależna od stanu isLogin
    Widget content = isLogin
        ? Column(
            children: [
              Text(
                'Logowanie',
                style: TextStyle(
                  fontSize: isSmallScreen ? 22 : 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              _buildTextField(
                hintText: 'Login',
                onChanged: (value) => _login = value,
              ),
              _buildTextField(
                hintText: 'Hasło',
                isPassword: true,
                onChanged: (value) => _password = value,
              ),
            ],
          )
        : Stepper(
            currentStep: _currentStep,
            onStepTapped: (step) => setState(() => _currentStep = step),
            onStepContinue: _currentStep < 4
                ? () => setState(() => _currentStep += 1)
                : () => _submitRegistration(),
            onStepCancel: _currentStep > 0
                ? () => setState(() => _currentStep -= 1)
                : null,
            steps: <Step>[
              Step(
                title: const Text('Podstawowe dane'),
                isActive: _currentStep >= 0,
                state:
                    _currentStep > 0 ? StepState.complete : StepState.indexed,
                content: Column(
                  children: [
                    _buildTextField(
                      hintText: 'Login',
                      onChanged: (value) => _login = value,
                    ),
                    _buildTextField(
                      hintText: 'Email',
                      onChanged: (value) => _email = value,
                    ),
                  ],
                ),
              ),
              Step(
                title: const Text('Dane osobowe'),
                isActive: _currentStep >= 1,
                state:
                    _currentStep > 1 ? StepState.complete : StepState.indexed,
                content: Column(
                  children: [
                    _buildTextField(
                      hintText: 'Imię',
                      onChanged: (value) => _firstName = value,
                    ),
                    _buildTextField(
                      hintText: 'Nazwisko',
                      onChanged: (value) => _lastName = value,
                    ),
                    _buildTextField(
                      hintText: 'Numer telefonu',
                      onChanged: (value) => _phoneNumber = value,
                    ),
                    _buildTextField(
                      hintText: 'Bio', // Pole bio
                      onChanged: (value) => _bio = value,
                    ),
                    _buildTextField(
                      hintText: 'Tagi (oddzielone przecinkami)', // Pole tagów
                      onChanged: (value) => _tags =
                          value.split(',').map((e) => e.trim()).toList(),
                    ),
                  ],
                ),
              ),
              Step(
                title: const Text('Hasło'),
                isActive: _currentStep >= 2,
                state:
                    _currentStep > 2 ? StepState.complete : StepState.indexed,
                content: Column(
                  children: [
                    _buildTextField(
                      hintText: 'Hasło',
                      isPassword: true,
                      onChanged: (value) => _password = value,
                    ),
                    _buildTextField(
                      hintText: 'Potwierdź hasło',
                      isPassword: true,
                      onChanged: (value) => _confirmPassword = value,
                    ),
                  ],
                ),
              ),
              Step(
                title: const Text('Przegląd'),
                isActive: _currentStep >= 3,
                state:
                    _currentStep > 3 ? StepState.complete : StepState.indexed,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildReviewRow('Login', _login),
                    _buildReviewRow('Email', _email),
                    _buildReviewRow('Imię', _firstName),
                    _buildReviewRow('Nazwisko', _lastName),
                    _buildReviewRow('Numer telefonu', _phoneNumber),
                    _buildReviewRow('Bio', _bio),
                    _buildReviewRow('Tagi', _tags.join(', ')),
                  ],
                ),
              ),
            ],
          );

    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          width: isSmallScreen ? size.width * 0.9 : size.width * 0.6,
          height: isLogin
              ? size.height * (isSmallScreen ? 0.55 : 0.5)
              : size.height * (isSmallScreen ? 0.75 : 0.8),
          decoration: BoxDecoration(
            color: Colors.blueGrey[300],
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              content,
              const SizedBox(height: 20),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    if (isLogin) {
                      _submitLogin();
                    } else {
                      _submitRegistration();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      isLogin ? 'Zaloguj się' : 'Zarejestruj się',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 16 : 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    isLogin = !isLogin; // Zmień stan na przeciwny
                    _currentStep = 0; // Reset kroków w Stepper
                  });
                },
                child: Text(
                  isLogin
                      ? 'Nie posiadasz konta? Zarejestruj się'
                      : 'Masz już konto? Zaloguj się',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
