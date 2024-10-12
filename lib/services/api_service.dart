import 'dart:convert';
import 'package:best_app/model/annoucment.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';

class ApiService {
  final String _baseUrl = 'https://0e7e-156-17-147-46.ngrok-free.app';

  Future<List<Annoucment>> getAnnoucments() async {
    try {
      final response = await http.get(
        Uri.parse('https://0e7e-156-17-147-46.ngrok-free.app/get_annoucements'),
        headers: {
          'accept': 'application/json',
          "ngrok-skip-browser-warning": "true"
        },
      );

      print(response.body); // Debug: Zobacz odpowiedź serwera

      if (response.statusCode == 200) {
        // Sprawdź, czy body nie jest puste
        if (response.body.isNotEmpty) {
          List<dynamic> data = json.decode(response.body);

          // Walidacja, aby upewnić się, że dane są listą
          if (data is List) {
            return data.map((json) => Annoucment.fromJson(json)).toList();
          } else {
            throw Exception('Unexpected data format');
          }
        } else {
          throw Exception('Empty response from the server');
        }
      } else {
        throw Exception('Failed to load announcements');
      }
    } catch (e) {
      throw Exception('Failed to connect to the API: $e');
    }
  }

  void addAnnoucment(Annoucment annoucment) async {
    print("TO DO: Add announcement to the API");
  }

  Future<bool> createUser(UserToDb user, String password) async {
    final url = Uri.parse('$_baseUrl/create_user');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': user.name,
          'second_name': user.surname,
          'bio': user.bio,
          'tags': user.tags,
          'email': user.email,
          'username': user.username,
          'profile_picture': user.profilePicture,
          'how_many_requests': user.howManyRequests,
          'user_type': user.userType,
          'academical_index': user.academicalIndex,
          'password': password, // Przekazanie hasła
        }),
      );
      print(response.body); // Debug: Zobacz odpowiedź serwera
      if (response.statusCode == 201 || response.statusCode == 200) {
        // Użytkownik został pomyślnie stworzony
        return true;
      } else {
        // Obsługa błędów
        print('Failed to create user: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error creating user: $e');
      return false;
    }
  }
}
