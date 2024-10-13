import 'dart:convert';
import 'package:best_app/model/annoucment.dart';
import 'package:http/http.dart' as http;

import '../model/annoucmentToDb.dart';
import '../model/user.dart';

class ApiService {
  final String _baseUrl = 'https://94c5-156-17-147-46.ngrok-free.app';

  Future<List<Annoucment>> getAnnoucments() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/get_annoucements'),
        headers: {
          'accept': 'application/json',
          "ngrok-skip-browser-warning": "true"
        },
      );

      if (response.statusCode == 200) {
        // Sprawdź, czy body nie jest puste
        if (response.body.isNotEmpty) {
          List<dynamic> data = json.decode(response.body);
          // Walidacja, aby upewnić się, że dane są listą
          return data.map((json) => Annoucment.fromJson(json)).toList();
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

  Future<bool> addAnnouncement(AnnoucmentToDb annoucment) async {
    final url = Uri.parse('$_baseUrl/add_annoucement');

    try {
      final response = await http.post(
        url,
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          "ngrok-skip-browser-warning": "true"
        },
        body: jsonEncode({
          'title': annoucment.title,
          'abstract': annoucment.abstract,
          'full_text': annoucment.fullText,
          'tags': annoucment.tags,
          'owner_id': annoucment.ownerId,
          'location': annoucment.location,
          'working_type': annoucment.workingType,
          'level_of_experience': annoucment.levelOfExperience,
          'requirements': annoucment.requirements,
          'is_active': true, // Zakładam, że ogłoszenie domyślnie jest aktywne
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Jeśli dodanie ogłoszenia się powiodło
        return true;
      } else {
        // Obsługa błędów
        print('Failed to add announcement: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error adding announcement: $e');
      return false;
    }
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

  Future<bool> validateUser(String username, String password) async {
    final url = Uri.parse('$_baseUrl/validate_user/$username/$password');

    try {
      final response = await http.post(
        url,
        headers: {
          'accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Zakładamy, że status 200 oznacza pomyślną walidację
        return true;
      } else {
        // Obsługa błędów
        print('Failed to validate user: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error validating user: $e');
      return false;
    }
  }

  Future<String?> getUserByUsername(String username) async {
    final url = Uri.parse('$_baseUrl/get_user/$username');

    try {
      final response = await http.get(
        url,
        headers: {
          'accept': 'application/json',
          "ngrok-skip-browser-warning": "true"
        },
      );

      if (response.statusCode == 200) {
        final String data = response.body;
        return data;
      } else {
        // Obsługa błędów
        print('Failed to get user: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }

  Future<bool> sendApplicationNote({
    required String title,
    required String content,
    required String ownerId,
    required String sendToId,
  }) async {
    final url = Uri.parse('$_baseUrl/send_note');

    try {
      final response = await http.post(
        url,
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          "ngrok-skip-browser-warning": "true"
        },
        body: jsonEncode({
          'title': title,
          'content': content,
          'owner_id': ownerId,
          'send_to_id': sendToId,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true; // Notatka wysłana pomyślnie
      } else {
        print('Failed to send note: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error sending note: $e');
      return false;
    }
  }

  Future<List<dynamic>> getAllMyNotes(String userId) async {
    final url = Uri.parse('$_baseUrl/get_all_my_notes/$userId');

    try {
      final response = await http.get(
        url,
        headers: {
          'accept': 'application/json',
          "ngrok-skip-browser-warning": "true"
        },
      );
      print(response.body);

      if (response.statusCode == 200) {
        List<dynamic> notes = jsonDecode(response.body);
        return notes;
      } else {
        print('Failed to fetch notes: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching notes: $e');
      return [];
    }
  }
}
