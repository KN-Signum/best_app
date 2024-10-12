import 'package:flutter/material.dart';

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
      _phoneNumber;

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
              // Pole tekstowe na login
              _buildTextField(
                hintText: 'Login',
                onChanged: (value) => _login = value,
              ),
              // Pole tekstowe na hasło
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
          padding: const EdgeInsets.all(20),
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
              content, // Załaduj odpowiednią zawartość (logowanie/rejestracja)
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

  // Widget do budowania pól tekstowych
  Widget _buildTextField(
      {required String hintText,
      bool isPassword = false,
      required ValueChanged<String> onChanged}) {
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

  // Metoda do obsługi zakończenia rejestracji
  void _submitRegistration() {
    // Logika rejestracji użytkownika
    print('Rejestracja zakończona');
    print('Login: $_login');
    print('Email: $_email');
    print('Imię: $_firstName');
    print('Nazwisko: $_lastName');
    print('Numer telefonu: $_phoneNumber');
    print('Hasło: $_password');

    // Możesz tutaj dodać logikę do zapisania danych użytkownika
  }

  // Metoda do obsługi logowania
  void _submitLogin() {
    // Logika logowania użytkownika
    print('Logowanie zakończone');
    print('Login: $_login');
    print('Hasło: $_password');

    // Możesz tutaj dodać logikę do uwierzytelnienia użytkownika
  }
}
