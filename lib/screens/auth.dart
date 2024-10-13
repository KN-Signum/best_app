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

  String? _login,
      _email,
      _password,
      _confirmPassword,
      _firstName,
      _lastName,
      _phoneNumber,
      _bio;
  List<String> _tags = [];

  // Rejestracja
  void _submitRegistration() async {
    if (_password != _confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match.')),
      );
      return;
    }

    UserToDb newUser = UserToDb(
      name: _firstName ?? '',
      surname: _lastName ?? '',
      bio: _bio ?? 'User didnt provide any bio',
      tags: _tags.isNotEmpty ? _tags : ['General'],
      email: _email ?? '',
      username: _login ?? '',
      profilePicture: 'default_profile',
      howManyRequests: 0,
      userType: 'Student',
      academicalIndex: 'N/A',
    );

    bool success = await ApiService().createUser(newUser, _password ?? '');

    if (success) {
      String? userId = await ApiService().getUserByUsername(_login!);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Home(userId: userId)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration failed.')),
      );
    }
  }

  // Logowanie
  void _submitLogin() async {
    if (_login == null || _password == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    bool success = await ApiService().validateUser(_login!, _password!);

    if (success) {
      String? userId = await ApiService().getUserByUsername(_login!);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Home(userId: userId)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Incorrect login or password.')),
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
        color: const Color.fromARGB(156, 249, 249, 249),
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

  // Widget do wyświetlania podsumowania danych
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

    Widget content = isLogin
        ? Column(
            children: [
              Text(
                'Login',
                style: TextStyle(
                  fontSize: isSmallScreen ? 22 : 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30),
              _buildTextField(
                hintText: 'Login',
                onChanged: (value) => _login = value,
              ),
              _buildTextField(
                hintText: 'Password',
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
                : _submitRegistration,
            onStepCancel: _currentStep > 0
                ? () => setState(() => _currentStep -= 1)
                : null,
            steps: <Step>[
              Step(
                title: const Text('Basic data'),
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
                title: const Text('Personal data'),
                isActive: _currentStep >= 1,
                state:
                    _currentStep > 1 ? StepState.complete : StepState.indexed,
                content: Column(
                  children: [
                    _buildTextField(
                      hintText: 'Name',
                      onChanged: (value) => _firstName = value,
                    ),
                    _buildTextField(
                      hintText: 'Surname',
                      onChanged: (value) => _lastName = value,
                    ),
                    _buildTextField(
                      hintText: 'Phone number',
                      onChanged: (value) => _phoneNumber = value,
                    ),
                    _buildTextField(
                      hintText: 'Bio',
                      onChanged: (value) => _bio = value,
                    ),
                    _buildTextField(
                      hintText: 'Tags (with comma separator)', // Tags field
                      onChanged: (value) => _tags =
                          value.split(',').map((e) => e.trim()).toList(),
                    ),
                  ],
                ),
              ),
              Step(
                title: const Text('Password'),
                isActive: _currentStep >= 2,
                state:
                    _currentStep > 2 ? StepState.complete : StepState.indexed,
                content: Column(
                  children: [
                    _buildTextField(
                      hintText: 'Password',
                      isPassword: true,
                      onChanged: (value) => _password = value,
                    ),
                    _buildTextField(
                      hintText: 'Confirm password',
                      isPassword: true,
                      onChanged: (value) => _confirmPassword = value,
                    ),
                  ],
                ),
              ),
              Step(
                title: const Text('Review'),
                isActive: _currentStep >= 3,
                state:
                    _currentStep > 3 ? StepState.complete : StepState.indexed,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildReviewRow('Login', _login),
                    _buildReviewRow('Email', _email),
                    _buildReviewRow('Name', _firstName),
                    _buildReviewRow('Surname', _lastName),
                    _buildReviewRow('Phone number', _phoneNumber),
                    _buildReviewRow('Bio', _bio),
                    _buildReviewRow('Tags', _tags.join(', ')),
                  ],
                ),
              ),
            ],
          );

    return Scaffold(
      backgroundColor: const Color.fromARGB(156, 190, 173, 233),
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
            color: const Color.fromARGB(156, 190, 173, 233),
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
                    backgroundColor: const Color.fromARGB(156, 164, 137, 234),
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
                      isLogin ? 'Login' : 'Register',
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
                    isLogin = !isLogin;
                    _currentStep = 0;
                  });
                },
                child: Text(
                  isLogin
                      ? 'You don\'t have an account? Register'
                      : 'Have an account? Login',
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
